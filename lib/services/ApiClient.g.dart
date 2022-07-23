// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://technofino.in/community/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginResponse> login(key, email, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'XF-Api-Key': key};
    _headers.removeWhere((k, v) => v == null);
    final _data = {'login': email, 'password': password};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'auth/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<NodeResponse> getNodes(api_key) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'XF-Api-Key': api_key};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<NodeResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'nodes/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = NodeResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ThreadResponse> getThreads(
      api_key, user_id, node_id, page, direction, order) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'direction': direction,
      r'order': order
    };
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ThreadResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'forums/${node_id}/threads/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ThreadResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostsOfThreadResponse> getPostsOfThreads(
      api_key, user_id, thread_id, page, direction, order) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'direction': direction,
      r'order': order
    };
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostsOfThreadResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'threads/${thread_id}/posts/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostsOfThreadResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ThreadResponse> getHomeThreads(api_key, page, direction, order) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'direction': direction,
      r'order': order
    };
    final _headers = <String, dynamic>{r'XF-Api-Key': api_key};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ThreadResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'threads/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ThreadResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ThreadResponse> findAllThreadsBy(
      api_key, user_id, page, direction, order, starter_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'direction': direction,
      r'order': order,
      r'starter_id': starter_id
    };
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ThreadResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'threads/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ThreadResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProfilePostsResponse> getProfilePosts(api_key, user_id, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProfilePostsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'users/${id}/profile-posts',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProfilePostsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ConversationResponse> getConversations(
      api_key, user_id, page, direction, order) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'direction': direction,
      r'order': order
    };
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ConversationResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'conversations/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ConversationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ConversationMessages> getConversationMessages(
      key, userId, conversation_id, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': key,
      r'XF-Api-User': userId
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ConversationMessages>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, 'conversations/${conversation_id}/messages',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ConversationMessages.fromJson(_result.data!);
    return value;
  }

  @override
  Future<NotificationResponse> getAlerts(
      api_key, user_id, page, direction, order) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'direction': direction,
      r'order': order
    };
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<NotificationResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'alerts/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = NotificationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostFromNotification> getPostOfAlerts(
      api_key, user_id, content_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostFromNotification>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'posts/${content_id}/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostFromNotification.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Map<String, bool>> postThread(
      api_key, user_id, node_id, title, message) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'node_id': node_id, 'title': title, 'message': message};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, bool>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'threads/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, bool>();
    return value;
  }

  @override
  Future<Map<String, UserData>> findUserEmail(api_key, user_id, email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'email': email};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, UserData>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'users/find-email',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!.map((k, dynamic v) =>
        MapEntry(k, UserData.fromJson(v as Map<String, dynamic>)));
    return value;
  }

  @override
  Future<ReactData> getReaponseOfReact(
      api_key, user_id, post_id, reaction_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'reaction_id': reaction_id};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReactData>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'posts/${post_id}/react',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReactData.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
