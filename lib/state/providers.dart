import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'notifier.dart';
import 'repository.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
//  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [Provider<Repository>(create: (context) => Repository())];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<Notifier>(create: (context) => Notifier(repository: context.read<Repository>())),
];
