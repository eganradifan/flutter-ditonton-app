import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/widgets/recommendations_poster.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should have text', (WidgetTester tester) async {
    await tester.pumpWidget(RecommendationsPoster(
      posterPath: "/f496cm9enuEsZkSPzCwnTESEK5s.jpg",
    ));
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}
