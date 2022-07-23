import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:technofino/data_classes/LoginResponse.dart';
import 'package:technofino/data_classes/NodeResponse.dart';
import 'package:technofino/data_classes/post_response/PostsOfThreadResponse.dart';
import 'package:technofino/data_classes/thread_response/ThreadResponse.dart';

import '../data_classes/UserData.dart';
import '../data_classes/conversation_response/ConversationMessages.dart';
import '../data_classes/conversation_response/ConversationResponse.dart';
import '../data_classes/notification_response/NotificationResponse.dart';
import '../data_classes/notification_response/PostFromNotification.dart';
import '../data_classes/react_response/ReactData.dart';
import '../data_classes/user_profile_posts_response/ProfilePostsResponse.dart';

part 'ApiClient.g.dart';

@RestApi(baseUrl: "https://technofino.in/community/api/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("auth/")
  @FormUrlEncoded()
  Future<LoginResponse> login(
    @Header("XF-Api-Key") String key,
    @Field("login") String email,
    @Field("password") String password,
  );

  @GET("nodes/")
  Future<NodeResponse> getNodes(
  @Header("XF-Api-Key") String api_key,
  );

  @GET("forums/{id}/threads/")
  Future<ThreadResponse> getThreads(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Path("id") int node_id,
  @Query("page") int page,
  @Query("direction")String direction,
  @Query("order") String order,
  );

  @GET("threads/{id}/posts/")
  Future<PostsOfThreadResponse> getPostsOfThreads(
      @Header("XF-Api-Key") String api_key,
      @Header("XF-Api-User") int user_id,
      @Path("id") int thread_id,
      @Query("page") int page,
      @Query("direction")String direction,
      @Query("order") String order,
  );

  @GET("threads/")
  Future<ThreadResponse> getHomeThreads(
      @Header("XF-Api-Key") String api_key,
      @Query("page") int page,
      @Query("direction")String direction,
      @Query("order") String order,
      );

  @GET("threads/")
  Future<ThreadResponse> findAllThreadsBy(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Query("page") int page,
  @Query("direction")String direction,
  @Query("order") String order,
  @Query("starter_id") int starter_id
  );

  @GET("users/{id}/profile-posts")
  Future<ProfilePostsResponse> getProfilePosts(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") String user_id,
  @Path("id") int id,
  );

  @GET("conversations/")
  Future<ConversationResponse> getConversations(
      @Header("XF-Api-Key") String api_key,
      @Header("XF-Api-User") String user_id,
      @Query("page") int page,
      @Query("direction")String direction,
      @Query("order") String order,
  );

  @GET("conversations/{id}/messages")
  Future<ConversationMessages> getConversationMessages(
  @Header("XF-Api-Key") String key,
  @Header("XF-Api-User") int userId,
  @Path("id")int conversation_id,
  @Query("page") int page,
  );

  @GET("alerts/")
  Future<NotificationResponse> getAlerts(
      @Header("XF-Api-Key") String api_key,
      @Header("XF-Api-User") String user_id,
      @Query("page") int page,
      @Query("direction")String direction,
      @Query("order") String order,
  );

  @GET("posts/{id}/")
  Future<PostFromNotification> getPostOfAlerts(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") String user_id,
  @Path("id") int content_id
  );

  @POST("threads/")
  @FormUrlEncoded()
  Future<Map<String, bool>> postThread(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") String user_id,
  @Field("node_id")int  node_id,
  @Field("title") String title,
  @Field("message")String message
  );

  @GET("users/find-email")
 Future<Map<String,UserData>> findUserEmail(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") String user_id,
  @Query("email") String email
  );

  @POST("posts/{id}/react")
  @FormUrlEncoded()
  Future<ReactData> getReaponseOfReact(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") String user_id,
  @Path("id")int post_id,
  @Field("reaction_id")int reaction_id
  );
}
