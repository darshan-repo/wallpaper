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
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(pattern);

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
                      'Report An Issue',
                      style: myTheme.textTheme.titleLarge,
                    ),
                    verticalSpace(0.01.sh),
                    Text(
                      'You have something to report? Great, we love feedback!',
                      style: myTheme.textTheme.labelMedium,
                    ),
                    verticalSpace(0.05.sh),
                    textFormField(
                      controller: txtEmailIdController,
                      hintText: 'Email',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email cannot be empty";
                        } else if (!regex.hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    verticalSpace(0.02.sh),
                    textFormField(
                      controller: txtSubjectController,
                      hintText: 'Subject',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Subject cannot be empty";
                        }
                        return null;
                      },
                    ),
                    verticalSpace(0.02.sh),
                    textFormField(
                      controller: txtMesssageController,
                      hintText: 'Message',
                      maxLines: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Message cannot be empty";
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
                          txtEmailIdController.clear();
                          txtSubjectController.clear();
                          txtMesssageController.clear();
                        }
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
      ),
    );
  }
}
