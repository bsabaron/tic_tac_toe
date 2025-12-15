/// Exception thrown when a repository operation fails.
class RepositoryOperationException implements Exception {
  const RepositoryOperationException(this.message);

  final String message;

  @override
  String toString() => 'RepositoryOperationException: $message';
}
