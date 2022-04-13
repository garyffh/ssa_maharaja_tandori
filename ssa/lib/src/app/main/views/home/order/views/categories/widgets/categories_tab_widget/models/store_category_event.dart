class StoreCategoryEvent {
  StoreCategoryEvent({
    required this.sysStoreCategoryId,
    required this.number,
    required this.name,
    required this.isSpecials,
  });


  final String sysStoreCategoryId;
  final int number;
  final String name;
  final bool isSpecials;
  final bool hasSubCategory = false;
  final int parentId = 0;

}
