import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

class ReportAnIssueScreen extends StatefulWidget {
  const ReportAnIssueScreen({super.key});

  @override
  State<ReportAnIssueScreen> createState() => _ReportAnIssueScreenState();
}

class _ReportAnIssueScreenState extends State<ReportAnIssueScreen> {
  GlobalKey<FormState> reportFormKey = GlobalKey<FormState>();
  TextEditingController txtEmailIdController = TextEditingController();
  TextEditingController txtSubjectController = TextEditingController();
  TextEditingController txtMesssageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(AppString.pattern);
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
              child: Form(
                key: reportFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.reportAnIssues,
                      style: myTheme.textTheme.titleLarge,
                    ),
                    verticalSpace(0.01.sh),
                    Text(
                      AppString.reportAnIssuesDesc,
                      style: myTheme.textTheme.labelMedium,
                    ),
                    verticalSpace(0.05.sh),
                    textFormField(
                      controller: txtEmailIdController,
                      hintText: AppString.email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppString.emailCannotBeEmpty;
                        } else if (!regex.hasMatch(value)) {
                          return AppString.enterAValidEmail;
                        }
                        return null;
                      },
                    ),
                    verticalSpace(0.02.sh),
                    textFormField(
                      controller: txtSubjectController,
                      hintText: AppString.subject,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppString.subjectCannotBeEmpty;
                        }
                        return null;
                      },
                    ),
                    verticalSpace(0.02.sh),
                    textFormField(
                      controller: txtMesssageController,
                      hintText: AppString.message,
                      maxLines: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppString.messsageCannotBeEmpty;
                        }
                        return null;
                      },
                    ),
                    verticalSpace(0.1.sh),
                    materialButton(
                      onPressed: () {
                        if (reportFormKey.currentState!.validate()) {
                          BlocProvider.of<CollectionBlocBloc>(context).add(
                            ReportAndIssue(
                              email: txtEmailIdController.text,
                              subject: txtSubjectController.text,
                              message: txtMesssageController.text,
                            ),
                          );
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
                                    AppString.thankYouForSharingYourFeedback,
                                    textAlign: TextAlign.center,
                                    style: myTheme.textTheme.titleMedium,
                                  ),
                                  verticalSpace(0.02.sh),
                                  Text(
                                    AppString
                                        .weveReceivedYourConcernsAndWereWorkingToResolveThem,
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
                                  buttonText: AppString.backToHome,
                                ),
                              ],
                            ),
                          );
                          txtEmailIdController.clear();
                          txtSubjectController.clear();
                          txtMesssageController.clear();
                        }
                      },
                      buttonColor: const Color(0xFFA098FA),
                      buttonText: AppString.submit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
