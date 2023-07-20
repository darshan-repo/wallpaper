import 'package:walper/libs.dart';
import 'package:walper/presentation/modules/privacy_policy/privacy_policy_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  static const route = 'PrivacyPolicyScreen';

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              verticalSpace(0.01.sh),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (notification) {
                    notification.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(0.02.sh),
                        Text(
                          'At www.walper.com, accessible from www.walper.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by www.walper.com and how we use it.',
                          textAlign: TextAlign.justify,
                          style: myTheme.textTheme.headlineSmall,
                        ),
                        verticalSpace(0.02.sh),
                        Text(
                          'If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.',
                          textAlign: TextAlign.justify,
                          style: myTheme.textTheme.headlineSmall,
                        ),
                        verticalSpace(0.02.sh),
                        Text(
                          'This Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in www.walper.com. This policy is not applicable to any information collected offline or via channels other than this website.',
                          textAlign: TextAlign.justify,
                          style: myTheme.textTheme.headlineSmall,
                        ),
                        verticalSpace(0.02.sh),
                        Text(
                          'Consent',
                          style: myTheme.textTheme.headlineMedium,
                        ),
                        verticalSpace(0.02.sh),
                        Text(
                          'By using our website, you hereby consent to our Privacy Policy and agree to its terms.',
                          textAlign: TextAlign.justify,
                          style: myTheme.textTheme.headlineSmall,
                        ),
                        verticalSpace(0.02.sh),
                        Text(
                          'Information we collect',
                          style: myTheme.textTheme.headlineMedium,
                        ),
                        verticalSpace(0.02.sh),
                        Text(
                          'The personal information that you are asked to provide, and the reasons why you are asked to provide it, will be made clear to you at the point we ask you to provide your personal information.',
                          textAlign: TextAlign.justify,
                          style: myTheme.textTheme.headlineSmall,
                        ),
                        verticalSpace(0.02.sh),
                        Text(
                          'If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide.',
                          textAlign: TextAlign.justify,
                          style: myTheme.textTheme.headlineSmall,
                        ),
                        verticalSpace(0.02.sh),
                        Text(
                          'When you register for an Account, we may ask for your contact information, including items such as name, company name, address, email address, and telephone number.',
                          textAlign: TextAlign.justify,
                          style: myTheme.textTheme.headlineSmall,
                        ),
                        verticalSpace(0.02.sh),
                        Text(
                          'How we use your information',
                          style: myTheme.textTheme.headlineMedium,
                        ),
                        verticalSpace(0.02.sh),
                        Text(
                          'We use the information we collect in various ways, including to:',
                          textAlign: TextAlign.justify,
                          style: myTheme.textTheme.headlineSmall,
                        ),
                        information(
                          title: '•  ',
                          value: ' Provide, operate, and maintain our website',
                        ),
                        information(
                          title: '•  ',
                          value: 'Improve, personalize, and expand our website',
                        ),
                        information(
                          title: '•  ',
                          value:
                              'Understand and analyze how you use our website',
                        ),
                        information(
                          title: '•  ',
                          value:
                              'Develop new products, services, features, and functionality',
                        ),
                        information(
                          title: '•  ',
                          value:
                              'Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the website, and for marketing and promotional purposes',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
