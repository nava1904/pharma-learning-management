enum VideoPlatform { youtube, vimeo, cloudflare, bunny, direct }

class VideoUrlParser {
  static VideoPlatform detectPlatform(String url) {
    final lower = url.toLowerCase();
    if (lower.contains('youtu.be/') ||
        lower.contains('youtube.com/watch') ||
        lower.contains('youtube.com/embed') ||
        lower.contains('youtube.com/shorts/') ||
        lower.contains('youtube.com/live/') ||
        lower.contains('m.youtube.com/')) {
      return VideoPlatform.youtube;
    }
    if (lower.contains('vimeo.com/')) {
      return VideoPlatform.vimeo;
    }
    if (lower.contains('cloudflarestream.com/') ||
        lower.contains('videodelivery.net/')) {
      return VideoPlatform.cloudflare;
    }
    if (lower.contains('mediadelivery.net/play/')) {
      return VideoPlatform.bunny;
    }
    return VideoPlatform.direct;
  }

  /// Prefer the platform implied by [url] (e.g. YouTube watch links) over a
  /// stored [platform] hint — old blocks may have `platform: direct` with a YouTube URL,
  /// which must not be loaded in an iframe (causes "refused to connect").
  static String toEmbedUrl(String url, VideoPlatform platform) {
    final detected = detectPlatform(url);
    final effective =
        detected != VideoPlatform.direct ? detected : platform;
    switch (effective) {
      case VideoPlatform.youtube:
        final videoId = _extractYouTubeId(url);
        if (videoId != null) {
          return 'https://www.youtube.com/embed/$videoId';
        }
        return url;
      case VideoPlatform.vimeo:
        final videoId = _extractVimeoId(url);
        if (videoId != null) {
          return 'https://player.vimeo.com/video/$videoId';
        }
        return url;
      case VideoPlatform.cloudflare:
        final videoId = _extractCloudflareId(url);
        if (videoId != null) {
          return 'https://iframe.videodelivery.net/$videoId';
        }
        return url;
      case VideoPlatform.bunny:
        return url;
      case VideoPlatform.direct:
        return url;
    }
  }

  static String? _extractYouTubeId(String url) {
    final patterns = [
      RegExp(r'[?&]v=([a-zA-Z0-9_-]{6,})'),
      RegExp(r'youtube\.com/watch\?v=([a-zA-Z0-9_-]+)'),
      RegExp(r'youtu\.be/([a-zA-Z0-9_-]+)'),
      RegExp(r'youtube\.com/embed/([a-zA-Z0-9_-]+)'),
      RegExp(r'youtube\.com/shorts/([a-zA-Z0-9_-]+)'),
      RegExp(r'youtube\.com/live/([a-zA-Z0-9_-]+)'),
    ];
    for (final pattern in patterns) {
      final match = pattern.firstMatch(url);
      if (match != null) return match.group(1);
    }
    return null;
  }

  static String? _extractVimeoId(String url) {
    final match = RegExp(r'vimeo\.com/(\d+)').firstMatch(url);
    return match?.group(1);
  }

  static String? _extractCloudflareId(String url) {
    final patterns = [
      RegExp(r'cloudflarestream\.com/([a-zA-Z0-9]+)'),
      RegExp(r'videodelivery\.net/([a-zA-Z0-9]+)'),
    ];
    for (final pattern in patterns) {
      final match = pattern.firstMatch(url);
      if (match != null) return match.group(1);
    }
    return null;
  }

  /// YouTube still image for loading/backdrop; returns null for non-YouTube URLs.
  static String? posterImageUrlForVideo(String url) {
    if (detectPlatform(url) != VideoPlatform.youtube) return null;
    final id = _extractYouTubeId(url);
    if (id == null) return null;
    return 'https://img.youtube.com/vi/$id/hqdefault.jpg';
  }

  static String platformLabel(VideoPlatform platform) {
    switch (platform) {
      case VideoPlatform.youtube:
        return 'YouTube';
      case VideoPlatform.vimeo:
        return 'Vimeo';
      case VideoPlatform.cloudflare:
        return 'Cloudflare Stream';
      case VideoPlatform.bunny:
        return 'Bunny Stream';
      case VideoPlatform.direct:
        return 'Direct URL';
    }
  }
}
