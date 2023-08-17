import 'package:ecommerce_app/constants/enums/sort_type.dart';
import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/filter_item.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/repositories/category_repository.dart';
import 'package:ecommerce_app/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

part 'search_filter_event.dart';
part 'search_filter_state.dart';

class SearchFilterBloc extends Bloc<SearchFilterEvent, SearchFilterState> {
  SearchFilterBloc() : super(SearchFilterInitial()) {
    on<LoadResultProducts>(_onLoadResultProducts);
    on<ChooseCategory>(_onChooseCategory);
    on<ChoosePriceValues>(_onChoosePriceValues);
    on<ChooseSortType>(_onChooseSortType);
    on<ChooseRatting>(_onChooseRatting);
    on<ApplyFilter>(_onApplyFilter);
  }
  List<Product> originalList = [];
  _onLoadResultProducts(
      LoadResultProducts event, Emitter<SearchFilterState> emit) async {
    try {
      emit(SearchFilterLoading());
      final List<Product> products =
          await ProductRepository().fetchAllProducts();
      final List<Product> resultProducts = products
          .where((element) =>
              element.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      originalList.addAll(resultProducts);
      FilterItem filterItem;
      if (resultProducts.isNotEmpty) {
        final List<Category> categories =
            await CategoryRepository().fetchCategories()
              ..removeWhere((element) => element.name == "New Arrivals");
        final priceValues = SfRangeValues(
            0,
            resultProducts
                .reduce((current, next) =>
                    current.price > next.price ? current : next)
                .price);
        filterItem = FilterItem(
            sortTypes: SortType.values,
            categories: categories,
            priceValues: priceValues,
            priceValuesSelected: priceValues,
            categorySelected: categories[0],
            ratingSelected: 5,
            sortTypeSelected: SortType.values[0]);
      } else {
        filterItem = const FilterItem(
            sortTypes: null,
            categories: null,
            priceValues: null,
            priceValuesSelected: null,
            categorySelected: null,
            ratingSelected: null,
            sortTypeSelected: null);
      }
      emit(SearchFilterLoaded(
          resultProducts: resultProducts, filterItem: filterItem));
    } catch (e) {
      emit(SearchFilterError(message: e.toString()));
    }
  }

  _onChooseCategory(ChooseCategory event, Emitter<SearchFilterState> emit) {
    try {
      final currentState = state as SearchFilterLoaded;
      final filterItem =
          currentState.filterItem.copyWith(categorySelected: event.category);
      emit(SearchFilterLoaded(
          resultProducts: currentState.resultProducts, filterItem: filterItem));
    } catch (e) {
      emit(SearchFilterError(message: e.toString()));
    }
  }

  _onChoosePriceValues(
      ChoosePriceValues event, Emitter<SearchFilterState> emit) {
    try {
      final currentState = state as SearchFilterLoaded;
      final filterItem = currentState.filterItem
          .copyWith(priceValuesSelected: event.priceValues);
      emit(SearchFilterLoaded(
          resultProducts: currentState.resultProducts, filterItem: filterItem));
    } catch (e) {
      emit(SearchFilterError(message: e.toString()));
    }
  }

  _onChooseSortType(ChooseSortType event, Emitter<SearchFilterState> emit) {
    try {
      final currentState = state as SearchFilterLoaded;
      final filterItem =
          currentState.filterItem.copyWith(sortTypeSelected: event.sortType);
      emit(SearchFilterLoaded(
          resultProducts: currentState.resultProducts, filterItem: filterItem));
    } catch (e) {
      emit(SearchFilterError(message: e.toString()));
    }
  }

  _onChooseRatting(ChooseRatting event, Emitter<SearchFilterState> emit) {
    try {
      final currentState = state as SearchFilterLoaded;
      final filterItem =
          currentState.filterItem.copyWith(ratingSelected: event.ratting);
      emit(SearchFilterLoaded(
          resultProducts: currentState.resultProducts, filterItem: filterItem));
    } catch (e) {
      emit(SearchFilterError(message: e.toString()));
    }
  }

  _onApplyFilter(ApplyFilter event, Emitter<SearchFilterState> emit) {
    try {
      final currentState = state as SearchFilterLoaded;
      final List<Product> resultProducts = [...originalList];
      final filterCategory = resultProducts
          .where((element) =>
              element.categoryId ==
              currentState.filterItem.categorySelected!.id)
          .toList();
      final filterPriceRange = filterCategory
          .where((element) =>
              element.price <=
                  currentState.filterItem.priceValuesSelected!.end &&
              element.price >=
                  currentState.filterItem.priceValuesSelected!.start)
          .toList();
      final filterSortBy =
          _sortBy(filterPriceRange, currentState.filterItem.sortTypeSelected!);
      final filterRating = filterSortBy
          .where((element) =>
              element.averageRating <=
                  currentState.filterItem.ratingSelected! &&
              element.averageRating >=
                  currentState.filterItem.ratingSelected! - 1)
          .toList();
      emit(SearchFilterLoaded(
          resultProducts: filterRating, filterItem: currentState.filterItem));
    } catch (e) {
      emit(SearchFilterError(message: e.toString()));
    }
  }

  List<Product> _sortBy(List<Product> products, SortType sortType) {
    switch (sortType) {
      case SortType.newToday:
        {
          return products
              .where((element) => _isProductLaunchedToday(element.createdAt))
              .toList();
        }
      case SortType.newThisWeek:
        {
          return products
              .where((element) => _isProductLaunchedThisWeek(element.createdAt))
              .toList();
        }
      case SortType.topSellers:
        {
          return products
            ..sort((a, b) => a.reviewCount - b.reviewCount)
            ..take(10).toList();
        }
      default:
        return products;
    }
  }

  bool _isProductLaunchedToday(DateTime productLaunchDate) {
    // Lấy ngày hôm nay
    DateTime today = DateTime.now();

    // So sánh ngày ra mắt sản phẩm với ngày hôm nay
    if (productLaunchDate.year == today.year &&
        productLaunchDate.month == today.month &&
        productLaunchDate.day == today.day) {
      return true; // Sản phẩm ra mắt trong ngày
    } else {
      return false; // Sản phẩm không ra mắt trong ngày
    }
  }

  bool _isProductLaunchedThisWeek(DateTime productLaunchDate) {
    // Lấy ngày hôm nay
    DateTime today = DateTime.now();

    // Lấy ngày đầu tuần (ngày thứ 2)
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));

    // Lấy ngày cuối tuần (ngày chủ nhật)
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    // So sánh ngày ra mắt sản phẩm với khoảng thời gian trong tuần
    if (productLaunchDate.isAfter(startOfWeek) &&
        productLaunchDate.isBefore(endOfWeek)) {
      return true; // Sản phẩm ra mắt trong tuần
    } else {
      return false; // Sản phẩm không ra mắt trong tuần
    }
  }
}
