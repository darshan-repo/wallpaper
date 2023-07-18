import 'package:wallpaper/libs.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const String route = 'SearchScreen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  TextEditingController txtSearchController = TextEditingController();

  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  int tabIndex = 0;
  bool isShowColor = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(paddingType: PaddingType.all, paddingValue: 0.01.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search',
            style: myTheme.textTheme.titleLarge,
          ),
          verticalSpace(0.01.sh),
          Text(
            'seaching through hundreds of photos will be so much easier now.',
            style: myTheme.textTheme.labelSmall,
          ),
          verticalSpace(0.02.sh),
          TextFormField(
            controller: txtSearchController,
            style: myTheme.textTheme.labelMedium,
            cursorColor: ColorManager.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorManager.secondaryColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                    color: ColorManager.secondaryColor, width: 1),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                    color: ColorManager.secondaryColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(104, 97, 228, 1),
                  width: 2,
                ),
              ),
              prefixIcon: const Icon(Icons.search, color: ColorManager.white),
              hintText: 'Search...',
              hintStyle: myTheme.textTheme.labelMedium,
            ),
          ),
          verticalSpace(0.02.sh),
          TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 2,
            onTap: (value) {
              setState(() {
                tabIndex = value;
              });
            },
            overlayColor:
                MaterialStateProperty.all(ColorManager.transparentColor),
            labelPadding:
                padding(paddingType: PaddingType.bottom, paddingValue: 0.01.sh),
            indicatorColor: const Color.fromRGBO(104, 97, 228, 1),
            tabs: [
              Text(
                'Photo',
                style: tabIndex == 0
                    ? myTheme.textTheme.displaySmall
                    : myTheme.textTheme.labelMedium,
              ),
              Text(
                'Category',
                style: tabIndex == 1
                    ? myTheme.textTheme.displaySmall
                    : myTheme.textTheme.labelMedium,
              ),
            ],
          ),
          verticalSpace(0.02.sh),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const [
                PhotosSearchScreen(),
                CategoriesSearchScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
