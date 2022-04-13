import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/main/services/store_status_display/store_status_display_bloc.dart';
import 'package:single_store_app/src/app/main/services/store_status_display/store_status_display_event.dart';
import 'package:single_store_app/src/app/main/views/home/order/models/category_sitems.dart';
import 'package:single_store_app/src/app/main/views/home/order/views/categories/categories_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/order/views/categories/categories_event.dart';
import 'package:single_store_app/src/app/main/views/home/order/views/categories/categories_state.dart';
import 'package:single_store_app/src/app/main/views/home/order/views/categories/widgets/categories_tab_widget/models/store_category_event.dart';
import 'package:single_store_app/src/app/main/views/home/order/views/categories/widgets/categories_tab_widget/widgets/sitem_widget.dart';
import 'package:single_store_app/src/app/models/business/store_category_read.dart';
import 'package:single_store_app/src/app/models/products/sitem.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';
import 'package:single_store_app/src/app/widgets/error/app_error_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/empty_widget.dart';

import '../categories_progress_dialog.dart';
import '../categories_progress_widget.dart';
import 'models/category_tab.dart';
import 'models/tab_build_result.dart';
import 'models/tab_range.dart';

enum BodyScrollDirection { none, down, up }

class CategoriesTabWidget extends StatefulWidget {
  const CategoriesTabWidget({
    Key? key,
    this.tabHeight = 58,
    this.tabAnimationDuration = const Duration(milliseconds: 150),
    this.bodyAnimationDuration = const Duration(milliseconds: 150),
    this.tabAnimationCurve = Curves.decelerate,
    this.bodyAnimationCurve = Curves.decelerate,
  }) : super(key: key);

  final double tabHeight;
  final Duration tabAnimationDuration;
  final Duration bodyAnimationDuration;
  final Curve tabAnimationCurve;
  final Curve bodyAnimationCurve;

  @override
  State<CategoriesTabWidget> createState() => _CategoriesTabWidgetState();
}

class _CategoriesTabWidgetState extends State<CategoriesTabWidget> {
  final EdgeInsetsGeometry kTabMargin =
      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0);

  final ValueNotifier<int> _index = ValueNotifier<int>(0);

  final ItemScrollController _bodyScrollController = ItemScrollController();
  final ItemPositionsListener _bodyPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController _tabScrollController = ItemScrollController();

  TabRange tabRange = TabRange(first: -1, last: -1);
  bool _tabClickMode = false;
  bool _allTabsLoaded = false;

  bool _contextInitialised = false;
  late BusinessSettingsBloc businessSettingsBloc;
  late CategoriesBloc categoriesBloc;
  late StoreStatusDisplayBloc storeStatusDisplayBloc;

  late List<CategoryTab> tabs;

  @override
  void initState() {
    super.initState();
    _bodyPositionsListener.itemPositions.addListener(_onInnerViewScrolled);
  }

  @override
  void didChangeDependencies() {
    final businessSettingsBloc = BlocProvider.of<BusinessSettingsBloc>(context);
    final categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    final storeStatusDisplayBloc =
        BlocProvider.of<StoreStatusDisplayBloc>(context);

    if (!_contextInitialised) {
      _contextInitialised = true;
      this.businessSettingsBloc = businessSettingsBloc;
      this.categoriesBloc = categoriesBloc;
      this.storeStatusDisplayBloc = storeStatusDisplayBloc;

      _initialise();
    } else {

      if (this.businessSettingsBloc != businessSettingsBloc ||
          this.categoriesBloc != categoriesBloc ||
          this.storeStatusDisplayBloc != storeStatusDisplayBloc) {
        this.businessSettingsBloc = businessSettingsBloc;
        this.categoriesBloc = categoriesBloc;
        this.storeStatusDisplayBloc = storeStatusDisplayBloc;

        _initialise();
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoriesBloc, CategoriesState>(
          listener: (context, state) async {
            final TabBuildResult tabBuildResult = _buildTabs(context, state);

            if (tabBuildResult.updateTabs) {
              setState(() => tabs = tabs);
            }

            if (tabBuildResult.scrollBodyIndex >= 0) {
              await Future<dynamic>.delayed(Duration.zero);

              await _bodyScrollController.scrollTo(
                index: tabBuildResult.scrollBodyIndex,
                duration: const Duration(milliseconds: 1),
                curve: widget.bodyAnimationCurve,
              );

              await Future<dynamic>.delayed(Duration.zero);

              _tabClickMode = false;

              _nextCategoryTabSitems(tabRange);
            }

            if (tabBuildResult.errorTabIndex >= 0) {
              await _tabScrollController.scrollTo(
                index: tabBuildResult.errorTabIndex,
                duration: const Duration(milliseconds: 1),
                curve: widget.tabAnimationCurve,
              );

              await _bodyScrollController.scrollTo(
                index: tabBuildResult.errorTabIndex,
                duration: const Duration(milliseconds: 1),
                curve: widget.bodyAnimationCurve,
              );

              _index.value = tabBuildResult.errorTabIndex;

              _tabClickMode = false;
            }

          },
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: widget.tabHeight,
            color: Theme.of(context).cardColor,
            child: ScrollablePositionedList.builder(
              itemCount: tabs.length,
              scrollDirection: Axis.horizontal,
              itemScrollController: _tabScrollController,
              itemBuilder: (context, index) {
                return ValueListenableBuilder<int>(
                  valueListenable: _index,
                  builder: (_, i, __) {
                    return tabs[index].doNotShow
                        ? const SizedBox.shrink()
                        : Container(
                            margin: kTabMargin,
                            child: index == i
                                ? ElevatedButton(
                                    onPressed: () {},
                                    child: tabs[index].listTab.tabLabel,
                                  )
                                : OutlinedButton(
                                    onPressed: () => _onTabPressed(index),
                                    child: tabs[index].listTab.tabLabel,
                                  ),
                          );
                  },
                );
              },
            ),
          ),
          Flexible(
            child: ScrollablePositionedList.builder(
              itemScrollController: _bodyScrollController,
              itemPositionsListener: _bodyPositionsListener,
              itemCount: tabs.length,
              itemBuilder: (_, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  tabs[index].listTab.listWidget(tabs[index].doNotShow),
                  Flexible(
                    child: tabs[index].listBody,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _initialise() {

    tabs = [];

    if(businessSettingsBloc.state.type != BusinessSettingStateType.loaded) {
      return;
    }

    final List<StoreCategoryRead> storeCategories =
        (businessSettingsBloc.state as BusinessSettingsStateLoaded)
            .storeCategories;



    tabs.add(CategoryTab.initialise(
      sysStoreCategoryId: Formats.emptyGuid(),
      isSpecials: true,
      sysStoreCategory: 'Specials',
      listBody: _singleWidgetListView(const EmptyWidget()),
    ));

    for (final StoreCategoryRead sysStoreCategory in storeCategories) {
      tabs.add(CategoryTab.initialise(
        sysStoreCategoryId: sysStoreCategory.sysStoreCategoryId,
        isSpecials: false,
        sysStoreCategory: sysStoreCategory.name,
        listBody: _singleWidgetListView(const EmptyWidget()),
      ));
    }
  }

  TabBuildResult _buildTabs(BuildContext context, CategoriesState state) {
    late CategoryTab? currentTab;

    bool updateTabs = false;
    int errorTabIndex = -1;
    int scrollBodyIndex = -1;

    switch (state.runtimeType) {
      case CategoriesStateRange:
        {
          final CategoriesStateRange categoriesStateRange =
              state as CategoriesStateRange;

          if (categoriesStateRange.categorySitems.isNotEmpty) {
            scrollBodyIndex = _updateTabs(categoriesStateRange.categorySitems);
            if (scrollBodyIndex >= 0) {
              updateTabs = true;
            }
          }

          break;
        }

      case CategoriesStateLoad:
        {
          final CategoriesStateLoad categoriesStateLoad =
              state as CategoriesStateLoad;
          currentTab = _findTab(categoriesStateLoad.sysStoreCategoryId);

          if (currentTab != null) {
            final CategoryTab tab = CategoryTab.copyFrom(
                currentTab,
                CategoryTabStatus.loaded,
                CategoryTabViewStatus.loaded,
                categoriesStateLoad.sitems.length,
                _categorySitems(context, categoriesStateLoad.sitems));

            _nextPendingTabSitems();

            _updateTab(currentTab, tab);
            _updateTabProcessingWidget();

            updateTabs = true;
          }

          break;
        }

      case CategoriesStatePending:
        {
          final CategoriesStatePending categoriesStatePending =
              state as CategoriesStatePending;
          currentTab = _findTab(categoriesStatePending.sysStoreCategoryId);

          if (currentTab != null) {
            final CategoryTab tab = CategoryTab.copyFrom(
              currentTab,
              CategoryTabStatus.pending,
              CategoryTabViewStatus.pending,
              -1,
              _singleWidgetListView(const EmptyWidget()),
            );

            _updateTab(currentTab, tab);
            _updateTabProcessingWidget();
            updateTabs = true;
          }
          break;
        }

      case CategoriesStateProcessing:
        {
          final CategoriesStateProcessing categoriesStateProcessing =
              state as CategoriesStateProcessing;
          currentTab = _findTab(categoriesStateProcessing.sysStoreCategoryId);

          if (currentTab != null) {
            final CategoryTab tab = CategoryTab.copyFrom(
              currentTab,
              CategoryTabStatus.processing,
              CategoryTabViewStatus.pending,
              -1,
              _singleWidgetListView(const EmptyWidget()),
            );

            _updateTab(currentTab, tab);
            _updateTabProcessingWidget();
            updateTabs = true;
          }

          break;
        }

      case CategoriesStateRangeBegin:
        {
          showDialog<CategoriesProgressDialog>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const CategoriesProgressDialog();
              });

          break;
        }

      case CategoriesStateRangeFinish:
        {
          // close wait dialog
          Navigator.of(context, rootNavigator: true).pop();

          break;
        }

      case CategoriesStateError:
        {
          final CategoriesStateError categoriesStateError =
              state as CategoriesStateError;

          if (categoriesStateError.categorySitems != null) {
            if (categoriesStateError.categorySitems!.isNotEmpty) {
              _updateTabs(categoriesStateError.categorySitems!);
            }
          }

          currentTab = _findTab(categoriesStateError.sysStoreCategoryId);

          if (currentTab != null) {
            errorTabIndex = tabs.indexOf(currentTab);

            final CategoryTab tab = CategoryTab.copyFrom(
                currentTab,
                CategoryTabStatus.error,
                CategoryTabViewStatus.loaded,
                -1,
                _selectErrorView(context, categoriesStateError));

            _updateTab(currentTab, tab);
            _updateTabProcessingWidget();

            updateTabs = true;
          }
          break;
        }
    }

    return TabBuildResult(
        updateTabs: updateTabs,
        errorTabIndex: errorTabIndex,
        scrollBodyIndex: scrollBodyIndex);
  }

  ListView _singleWidgetListView(Widget widget) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return widget;
      },
    );
  }

  CategoryTab? _findTab(String sysStoreCategoryId) {
    CategoryTab? rtn;

    for (final CategoryTab tab in tabs) {
      if (tab.sysStoreCategoryId == sysStoreCategoryId) {
        rtn = tab;
        break;
      }
    }
    return rtn;
  }

  ListView _categorySitems(BuildContext context, List<Sitem> sitems) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sitems.length,
      itemBuilder: (BuildContext context, int index) {
        return SitemWidget(sitem: sitems[index]);
      },
    );
  }

  int _updateTabs(List<CategorySitems> categorySitems) {
    int rtn = -1;

    for (final CategorySitems categorySitems in categorySitems) {
      final CategoryTab? currentTab =
          _findTab(categorySitems.category.sysStoreCategoryId);

      if (currentTab != null) {
        rtn = tabs.indexOf(currentTab);

        final CategoryTab tab = CategoryTab.copyFrom(
            currentTab,
            CategoryTabStatus.loaded,
            CategoryTabViewStatus.loaded,
            categorySitems.sitems.length,
            _categorySitems(context, categorySitems.sitems));

        _updateTab(currentTab, tab);
      }
    }

    return rtn;
  }

  void _updateTab(CategoryTab currentTab, CategoryTab? tab) {
    if (tab == null) {
      return;
    }

    final int index = tabs.indexOf(currentTab);

    if (index < 0) {
      return;
    }

    tabs[index] = tab;
  }

  void _nextPendingTabSitems() {
    CategoryTab? categoryTab;

    for (int i = tabRange.first; i <= tabRange.last; i++) {
      final tab = tabs[i];
      if (tab.categoryTabStatus == CategoryTabStatus.pending ||
          tab.categoryTabStatus == CategoryTabStatus.error) {
        categoryTab = tab;

        break;
      }
    }

    if (categoryTab != null) {
      categoriesBloc.add(CategoriesEventGetSitems(
        sysStoreCategoryId: categoryTab.sysStoreCategoryId,
        sysStoreCategory: categoryTab.listTab.text,
        isSpecials: categoryTab.isSpecials,
      ));
    }
  }

  void _updateTabProcessingWidget() {
    bool isProcessingWidget = false;
    int processingWidgetsCount = 0;
    CategoryTab? firstProcessingTab;

    for (final CategoryTab tab in tabs) {
      if (tab.categoryTabViewStatus == CategoryTabViewStatus.processing) {
        isProcessingWidget = true;
      }
      if (tab.categoryTabStatus == CategoryTabStatus.processing) {
        processingWidgetsCount++;
        firstProcessingTab ??= tab;
      }
    }

    if (!isProcessingWidget && processingWidgetsCount > 0) {
      final CategoryTab processingTab = CategoryTab.copyFrom(
          firstProcessingTab!,
          CategoryTabStatus.processing,
          CategoryTabViewStatus.processing,
          -1,
          _singleWidgetListView(const CategoriesProgressWidget()));

      _updateTab(firstProcessingTab, processingTab);
    }
  }

  ListView _selectErrorView(
      BuildContext context, CategoriesStateError categoriesStateError) {
    final CategoriesBloc categoriesBloc =
        BlocProvider.of<CategoriesBloc>(context);

    return _singleWidgetListView(
      AppErrorWidget.fromErrorView(
        errorView: categoriesStateError,
        tryAgainCallback: () => categoriesBloc.add(CategoriesEventGetSitems(
          sysStoreCategoryId: categoriesStateError.sysStoreCategoryId,
          sysStoreCategory: categoriesStateError.sysStoreCategory,
          isSpecials: categoriesStateError.isSpecials,
        )),
      ),
    );
  }

  Future<void> _onInnerViewScrolled() async {
    bool tabRangeChanged = false;

    final positions = _bodyPositionsListener.itemPositions.value;

    if (positions.isEmpty) {
      return;
    }

    BodyScrollDirection scrollDirection = BodyScrollDirection.none;

    final int first = positions
        .where((ItemPosition position) => position.itemTrailingEdge > 0)
        .reduce((ItemPosition min, ItemPosition position) =>
            position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
        .index;

    final int last = positions
        .where((ItemPosition position) => position.itemLeadingEdge < 1)
        .reduce((ItemPosition max, ItemPosition position) =>
            position.itemLeadingEdge > max.itemLeadingEdge ? position : max)
        .index;

    if (!tabRange.isEqualTo(first, last)) {
      tabRangeChanged = true;
      if (first > tabRange.first) {
        scrollDirection = BodyScrollDirection.down;
      } else if (first < tabRange.first) {
        scrollDirection = BodyScrollDirection.up;
      }

      tabRange = TabRange(first: first, last: last);
    }

    if (_tabClickMode) {
      return;
    }

    final firstIndex = positions.elementAt(0).index;

    if (scrollDirection == BodyScrollDirection.down) {
      if (firstIndex > _index.value) {
        await _handleTabScroll(firstIndex);
      }
    } else if (scrollDirection == BodyScrollDirection.up) {
      if (firstIndex != _index.value) {
        await _handleTabScroll(firstIndex);
      }
    }

    storeStatusDisplayBloc.add(
      StoreStatusDisplayEventUpdateBanner(
          showBanner:
              first < 1 && positions.elementAt(0).itemLeadingEdge > -0.3),
    );

    if (tabRangeChanged && !_allTabsLoaded) {
      _nextCategoryTabSitems(tabRange);
    }
  }

  Future<void> _handleTabScroll(int index) async {
    _index.value = index;
    await _tabScrollController.scrollTo(
      index: _index.value,
      duration: widget.tabAnimationDuration,
      curve: widget.tabAnimationCurve,
    );
  }

  void _nextCategoryTabSitems(TabRange tabRange) {
    CategoryTab? categoryTab;

    for (int i = tabRange.first; i <= tabRange.last; i++) {
      final tab = tabs[i];

      if (tab.categoryTabStatus == CategoryTabStatus.error) {
        break;
      } else if (tab.categoryTabStatus == CategoryTabStatus.pending) {
        categoryTab = tab;
        break;
      }
    }

    if (categoryTab != null) {
      categoriesBloc.add(CategoriesEventGetSitems(
        sysStoreCategoryId: categoryTab.sysStoreCategoryId,
        sysStoreCategory: categoryTab.listTab.text,
        isSpecials: categoryTab.isSpecials,
      ));
    } else {
      _allTabsLoaded = _allTabsAreLoaded();
    }
  }

  Future<void> _onTabPressed(int index) async {
    if (_allTabsLoaded) {
      await _tabScrollController.scrollTo(
        index: index,
        duration: widget.tabAnimationDuration,
        curve: widget.tabAnimationCurve,
      );

      await _bodyScrollController.scrollTo(
        index: index,
        duration: widget.bodyAnimationDuration,
        curve: widget.bodyAnimationCurve,
      );

      _index.value = index;
    } else {
      final List<StoreCategoryEvent> storeCategories =
          _storeCategoriesFromIndex(index);

      if (storeCategories.isNotEmpty) {
        _tabClickMode = true;

        await _tabScrollController.scrollTo(
          index: index,
          duration: widget.tabAnimationDuration,
          curve: widget.tabAnimationCurve,
        );

        _index.value = index;

        categoriesBloc.add(CategoriesEventGetSitemRange(
          storeCategories: storeCategories,
        ));
      } else {
        await _tabScrollController.scrollTo(
          index: index,
          duration: widget.tabAnimationDuration,
          curve: widget.tabAnimationCurve,
        );

        await _bodyScrollController.scrollTo(
          index: index,
          duration: widget.bodyAnimationDuration,
          curve: widget.bodyAnimationCurve,
        );

        _index.value = index;

        _allTabsLoaded = _allTabsAreLoaded();
      }
    }
  }

  List<StoreCategoryEvent> _storeCategoriesFromIndex(int index) {
    final List<StoreCategoryEvent> rtn = [];

    for (int i = tabRange.first; i <= index; i++) {
      final tab = tabs[i];
      if (tab.categoryTabStatus == CategoryTabStatus.pending ||
          tab.categoryTabStatus == CategoryTabStatus.error) {
        rtn.add(StoreCategoryEvent(
            sysStoreCategoryId: tab.sysStoreCategoryId,
            isSpecials: tab.isSpecials,
            number: i + 1,
            name: tab.listTab.text));
      }
    }

    return rtn;
  }

  bool _allTabsAreLoaded() {
    bool rtn = true;

    for (final CategoryTab tab in tabs) {
      if (tab.categoryTabStatus != CategoryTabStatus.loaded) {
        rtn = false;
        break;
      }
    }

    return rtn;
  }

  @override
  void dispose() {
    _bodyPositionsListener.itemPositions.removeListener(_onInnerViewScrolled);
    return super.dispose();
  }
}
