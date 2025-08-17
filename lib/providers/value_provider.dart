import '../models/product_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final navIndexProvider = StateProvider<int>((_) => 0);

final searchProductProvider = StateProvider.autoDispose<String?>((_) => null);

final productListsProvider = StreamProvider.autoDispose<List<ProductModel>>((
  ref,
) async* {
  final search = ref.watch(searchProductProvider)?.trim();
  final List<ProductModel> result = (search != null && search.isNotEmpty)
      ? sampleProducts
            .where(
              (product) =>
                  product.name.toLowerCase().contains(search.toLowerCase()),
            )
            .toList()
      : sampleProducts;

  yield result;
});
