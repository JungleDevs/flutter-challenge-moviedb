import 'package:flutter/material.dart';

import 'package:jungle/app/core/repositories/trending_movies_repository.dart';
import 'app/app_widget.dart';

void main() => runApp(
      AppWidget(
        repository: TrendingMoviesRepository(),
      ),
    );
