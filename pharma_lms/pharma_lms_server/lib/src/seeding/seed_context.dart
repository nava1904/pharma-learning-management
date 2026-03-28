class SeedContext {
  SeedContext({
    required this.orgId,
    required this.siteIds,
    required this.deptIds,
  });

  final int orgId;
  final List<int> siteIds;
  final List<int> deptIds;
}
