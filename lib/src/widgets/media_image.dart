part of netflix;

Widget mediaImage(
  String? path, {
  BoxFit fit = BoxFit.cover,
  double? width,
  double? height,
}) {
  final String safePath = (path ?? '').trim();
  const String fallback = 'assets/images/default-image.png';

  if (safePath.isEmpty) {
    return Image.asset(fallback, fit: fit, width: width, height: height);
  }

  if (safePath.startsWith('assets/') || safePath.startsWith('screenshots/')) {
    return Image.asset(safePath, fit: fit, width: width, height: height);
  }

  return Image.network(
    safePath,
    fit: fit,
    width: width,
    height: height,
    errorBuilder: (context, error, stackTrace) =>
        Image.asset(fallback, fit: fit, width: width, height: height),
  );
}
