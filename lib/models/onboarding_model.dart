class OnboardingContent {
  final String? title;
  final String? image;
  final String? discription;

  OnboardingContent({this.title, this.image, this.discription});
}

List<OnboardingContent> onBoarding = [
  OnboardingContent(
    title: "Discover Event",
    image: "assets/img/calendar.svg",
    discription:
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum",
  ),
  OnboardingContent(
    title: "Lean To Code",
    image: "assets/img/binary-code.svg",
    discription:
        "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
  ),
  OnboardingContent(
    title: "Join Community",
    image: "assets/img/team.svg",
    discription:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old",
  )
];
