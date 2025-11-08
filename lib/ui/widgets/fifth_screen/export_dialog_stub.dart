// Stub for non-web platforms - should not be called
void webFileDownload(List<int> bytes, String fileName) {
  throw UnsupportedError('webFileDownload is only available on web platforms');
}

String getWebLocationHref() {
  throw UnsupportedError(
      'getWebLocationHref is only available on web platforms');
}
