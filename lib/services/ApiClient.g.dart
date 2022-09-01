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
  Future<NodeResponse> getNodes(api_key, user_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
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
  Future<Map<String, PostsOfThreads>> getPostsOfLastPostId(
      api_key, last_post_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'XF-Api-Key': api_key};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, PostsOfThreads>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'posts/${last_post_id}/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!.map((k, dynamic v) =>
        MapEntry(k, PostsOfThreads.fromJson(v as Map<String, dynamic>)));
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
  Future<ConversationResponse> getUnViewedConversations(
      api_key, user_id, unread) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'unread': unread};
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
  Future<NotificationResponse> getUnViewedAlerts(
      api_key, user_id, unread) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'unviewed': unread};
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
  Future<CreateNewThreadResponse> postThread(
      api_key, user_id, node_id, title, message, attachment_key) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'node_id': node_id,
      'title': title,
      'message': message,
      'attachment_key': attachment_key
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CreateNewThreadResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'threads/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CreateNewThreadResponse.fromJson(_result.data!);
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

  @override
  Future<Map<String, String>> generateAttachmentKeyForReplyConversation(
      api_key, user_id, message_id, type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'context[conversation_id]': message_id, 'type': type};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, String>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'attachments/new-key',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, String>();
    return value;
  }

  @override
  Future<Map<String, AttachmentsData>> postAttachmentFile(
      api_key, user_id, file, attachmentKey) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.files.add(MapEntry(
        'attachment',
        MultipartFile.fromFileSync(file.path,
            filename: file.path.split(Platform.pathSeparator).last)));
    _data.fields.add(MapEntry('key', attachmentKey));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, AttachmentsData>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'attachments/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!.map((k, dynamic v) =>
        MapEntry(k, AttachmentsData.fromJson(v as Map<String, dynamic>)));
    return value;
  }

  @override
  Future<Map<String, bool>> postConversationReply(
      api_key, user_id, conversation_id, message, attachment_key) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'conversation_id': conversation_id,
      'message': message,
      'attachment_key': attachment_key
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, bool>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'conversation-messages/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, bool>();
    return value;
  }

  @override
  Future<Map<String, String>> generateAttachmentKeyForPostsOfThreads(
      api_key, user_id, thread_id, type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'context[thread_id]': thread_id, 'type': type};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, String>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'attachments/new-key',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, String>();
    return value;
  }

  @override
  Future<Map<String, bool>> getResponseOfPostsOfThreadsComments(
      api_key, user_id, thread_id, message, attachment_key) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'thread_id': thread_id,
      'message': message,
      'attachment_key': attachment_key
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, bool>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'posts/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, bool>();
    return value;
  }

  @override
  Future<Map<String, String>> generateAttachmentKeyForUserProfile(
      api_key, user_id, profile_user_id, type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'context[profile_user_id]': profile_user_id, 'type': type};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, String>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'attachments/new-key',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, String>();
    return value;
  }

  @override
  Future<Map<String, bool>> getResponseOfProfilePostsOfUpdateStatus(
      api_key, user_id, profile_user_id, message, attachment_key) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'user_id': profile_user_id,
      'message': message,
      'attachment_key': attachment_key
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, bool>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'profile-posts/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, bool>();
    return value;
  }

  @override
  Future<ReactData> getResponseOfProfilePostsReact(
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
            .compose(_dio.options, 'profile-posts/${post_id}/react',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReactData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReactData> getResponseOfProfilePostsOfCommentsReact(
      api_key, user_id, profile_comment_id, reaction_id) async {
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
            .compose(_dio.options,
                'profile-post-comments/${profile_comment_id}/react',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReactData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Map<String, bool>> markReadConversation(
      api_key, user_id, conversation_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, bool>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, 'conversations/${conversation_id}/mark-read',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, bool>();
    return value;
  }

  @override
  Future<Map<String, bool>> markReadAlerts(
      api_key, user_id, alert_id, read, viewed) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'read': read, 'viewed': viewed};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, bool>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'alerts/${alert_id}/mark',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, bool>();
    return value;
  }

  @override
  Future<LoginResponse> updateUserProfileImage(api_key, user_id, file) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.files.add(MapEntry(
        'avatar',
        MultipartFile.fromFileSync(file.path,
            filename: file.path.split(Platform.pathSeparator).last)));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'me/avatar',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FilterData> findUserByName(api_key, username) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'username': username};
    final _headers = <String, dynamic>{r'XF-Api-Key': api_key};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FilterData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'users/find-name',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FilterData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ThreadResponse> getForumsResponseByFilter(
      api_key, node_id, direction, order, starter_id, last_days) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'direction': direction,
      r'order': order,
      r'starter_id': starter_id,
      r'last_days': last_days
    };
    final _headers = <String, dynamic>{r'XF-Api-Key': api_key};
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
  Future<Map<String, bool>> getResponseOfUserProfilePostsOfComments(
      api_key, user_id, profile_post_id, message, attachment_key) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'profile_post_id': profile_post_id,
      'message': message,
      'attachment_key': attachment_key
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, bool>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'profile-post-comments/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, bool>();
    return value;
  }

  @override
  Future<Map<String, bool>> generateAttachmentKeyForUserProfilePostsOfComments(
      api_key, user_id, profile_post_id, type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'context[profile_post_id]': profile_post_id, 'type': type};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, bool>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'attachments/new-key',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, bool>();
    return value;
  }

  @override
  Future<Map<String, bool>> deleteConversation(
      api_key, user_id, conversation_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, bool>>(Options(
                method: 'DELETE',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'conversations/${conversation_id}/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, bool>();
    return value;
  }

  @override
  Future<Map<String, bool>> starConversation(
      api_key, user_id, conversation_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, bool>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'conversations/${conversation_id}/star',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, bool>();
    return value;
  }

  @override
  Future<Map<String, String>> generateAttachmentKeyForPostOfThread(
      api_key, user_id, node_id, type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'context[node_id]': node_id, 'type': type};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, String>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'attachments/new-key',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, String>();
    return value;
  }

  @override
  Future<Map<String, String>> generateAttachmentKeyForStartConversation(
      api_key, user_id, type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'type': type};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, String>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'attachments/new-key',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, String>();
    return value;
  }

  @override
  Future<Map<String, bool>> startNewConversation(
      api_key,
      user_id,
      recipient_ids,
      title,
      message,
      attachment_key,
      conversation_open,
      open_invite) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'recipient_ids[]': recipient_ids,
      'title': title,
      'message': message,
      'attachment_key': attachment_key,
      'conversation_open': conversation_open,
      'open_invite': open_invite
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, bool>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'conversations/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, bool>();
    return value;
  }

  @override
  Future<Map<String, bool>> updateSpecificPost(
      api_key, user_id, message, attachment_key, post_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'message': message, 'attachment_key': attachment_key};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, bool>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'posts/${post_id}/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, bool>();
    return value;
  }

  @override
  Future<Map<String, String>> generateAttachmentKeyForUpdateOfSpecificPost(
      api_key, user_id, thread_id, type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'XF-Api-Key': api_key,
      r'XF-Api-User': user_id
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'context[post_id]': thread_id, 'type': type};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, String>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'attachments/new-key',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String, String>();
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
