import '../../feature/home/data/model/home_model.dart' as home;

class DummyData {
  static home.HomeModel get homeModel => home.HomeModel(
        status: true,
        message: '',
        data: home.HomeData(
          banners: List.generate(
            3,
            (index) => home.BannerModel(
              id: index,
              name: const home.LocalizedText(ar: 'عنوان تجريبي', en: 'Dummy Title'),
              url: '',
              image: '',
            ),
          ),
          services: List.generate(
            5,
            (index) => home.ServiceModel(
              id: index,
              title: const home.LocalizedText(ar: 'خدمة تجريبية', en: 'Dummy Service'),
              shortDescription: const home.LocalizedText(
                  ar: 'وصف قصير تجريبي', en: 'Dummy short description'),
              imageUrl: '',
              slug: '',
            ),
          ),
          products: List.generate(
            5,
            (index) => home.ProductModel(
              id: index,
              title: const home.LocalizedText(ar: 'منتج تجريبي', en: 'Dummy Product'),
              summary: const home.LocalizedText(ar: 'ملخص تجريبي', en: 'Dummy summary'),
              imageUrl: '',
              slug: '',
            ),
          ),
          blogs: List.generate(
            3,
            (index) => home.BlogModel(
              id: index,
              title: const home.LocalizedText(ar: 'مدونة تجريبية', en: 'Dummy Blog'),
              excerpt: const home.LocalizedText(ar: 'مقتطف تجريبي', en: 'Dummy excerpt'),
              imageUrl: '',
              createdAt: '2023-01-01',
            ),
          ),
        ),
      );

}
