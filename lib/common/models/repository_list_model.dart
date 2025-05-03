import 'package:equatable/equatable.dart';

import 'repository_model.dart';

class RepositoryListModel extends Equatable {
  final List<RepositoryModel> _repositories;

  RepositoryListModel({List<RepositoryModel>? repositories})
      : _repositories = repositories ?? [];

  void addRepository(RepositoryModel repository) {
    _repositories.add(repository);
  }

  void removeRepository(RepositoryModel repository) {
    _repositories.remove(repository);
  }

  List<RepositoryModel> getRepositories() {
    return _repositories;
  }

  RepositoryModel getRepositoryByPath(String path) {
    return _repositories.firstWhere((element) => element.path == path);
  }

  bool repositoryExistsByPath(String path) {
    return _repositories.any((element) => element.path == path);
  }

  factory RepositoryListModel.fromJson(Map<String, dynamic> json) {
    List<RepositoryModel> repositories = [];
    if (json["repositories"] != null) {
      for (var repository in json["repositories"]) {
        repositories.add(RepositoryModel.fromJson(repository));
      }
    }

    return RepositoryListModel(
      repositories: repositories,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> jsonRepositories = [];
    for (var repository in _repositories) {
      jsonRepositories.add(repository.toJson());
    }
    return {
      "repositories": jsonRepositories,
    };
  }

  @override
  List<Object?> get props => [_repositories];
}
