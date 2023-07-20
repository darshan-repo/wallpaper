import 'package:walper/libs.dart';

class ReportAnIssueScreen extends StatefulWidget {
  const ReportAnIssueScreen({super.key});
  static const route = 'ReportAnIssueScreen';

  @override
  State<ReportAnIssueScreen> createState() => _ReportAnIssueScreenState();
}

class _ReportAnIssueScreenState extends State<ReportAnIssueScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        appBar: appbar(
          context,
          leadingOnTap: () {
            Get.off(const BottomNavigationBarScreen());
          },
        ),
        body: Padding(
          padding: padding(paddingType: PaddingType.all, paddingValue: 0.02.sh),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Privacy Policy',
                    style: myTheme.textTheme.titleLarge,
                  ),
                  verticalSpace(0.01.sh),
                  Text(
                    'Your downloads are listed below.',
                    style: myTheme.textTheme.labelMedium,
                  ),
                  verticalSpace(0.1.sh),
                  textFormField(
                    hintText: 'Email',
                  ),
                  verticalSpace(0.02.sh),
                  textFormField(
                    hintText: 'Subject',
                  ),
                  verticalSpace(0.02.sh),
                  textFormField(
                    hintText: 'Message',
                    maxLines: 10,
                  ),
                  verticalSpace(0.1.sh),
                  materialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: ColorManager.secondaryColor,
                          iconPadding: padding(
                            paddingType: PaddingType.LTRB,
                            left: 0.04.sw,
                            right: 0.04.sw,
                          ),
                          icon: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 0.05.sh,
                              width: 0.1.sw,
                              margin: margin(
                                marginType: MarginType.top,
                                marginValue: 0.01.sh,
                              ),
                              decoration: BoxDecoration(
                                color: ColorManager.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                          actionsPadding: padding(
                            paddingType: PaddingType.all,
                            paddingValue: 0.02.sh,
                          ),
                          titlePadding: padding(
                              paddingType: PaddingType.top,
                              paddingValue: 0.02.sh),
                          title: Image.asset(ImageAssetManager.done),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Thank You For Sharing Your Feedback!',
                                textAlign: TextAlign.center,
                                style: myTheme.textTheme.titleMedium,
                              ),
                              verticalSpace(0.02.sh),
                              Text(
                                'We\'ve received your concerns, and we\'re working to resolve them.',
                                textAlign: TextAlign.center,
                                style: myTheme.textTheme.headlineSmall,
                              ),
                            ],
                          ),
                          elevation: 2,
                          shadowColor: ColorManager.white,
                          actions: [
                            materialButton(
                              onPressed: () {
                                Get.off(const BottomNavigationBarScreen());
                              },
                              buttonColor:
                                  const Color.fromRGBO(160, 152, 250, 1),
                              buttonText: 'Back to home',
                            ),
                          ],
                        ),
                      );
                    },
                    buttonColor: const Color(0xFFA098FA),
                    buttonText: 'Submit',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
