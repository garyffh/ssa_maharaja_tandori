class TabRange {
  TabRange({
    required this.first,
    required this.last,
  });

  TabRange.copy(TabRange value) : this(first: value.first, last: value.last);

  final int first;
  final int last;

  bool isEqualTo(int first, int last) {
    return this.first == first && this.last == last;
  }

}
