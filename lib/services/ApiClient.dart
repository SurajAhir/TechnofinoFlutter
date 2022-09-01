import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:technofino/data_classes/post_response/PostsOfThreadResponse.dart';
import 'package:technofino/data_classes/thread_response/CreateNewThreadResponse.dart';
import 'package:technofino/data_classes/thread_response/ThreadResponse.dart';
import '../data_classes/attachment_response/AttachmentsData.dart';
import '../data_classes/conversation_response/ConversationMessages.dart';
import '../data_classes/conversation_response/ConversationResponse.dart';
import '../data_classes/forume_data/NodeResponse.dart';
import '../data_classes/login_response/LoginResponse.dart';
import '../data_classes/login_response/UserData.dart';
import '../data_classes/notification_response/NotificationResponse.dart';
import '../data_classes/notification_response/PostFromNotification.dart';
import '../data_classes/post_response/PostsOfThreads.dart';
import '../data_classes/react_response/ReactData.dart';
import '../data_classes/thread_response/FilterData.dart';
import '../data_classes/thread_response/Threads.dart';
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
  @Header("XF-Api-User") String user_id,
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

  @GET("posts/{id}/")
  Future<Map<String,PostsOfThreads>> getPostsOfLastPostId(
      @Header("XF-Api-Key") String api_key,
      @Path("id") int last_post_id,
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
  @Header("XF-Api-User") int user_id,
  @Path("id") int id,
  );

  @GET("conversations/")
  Future<ConversationResponse> getConversations(
      @Header("XF-Api-Key") String api_key,
      @Header("XF-Api-User")int user_id,
      @Query("page") int page,
      @Query("direction")String direction,
      @Query("order") String order,
  );

  @GET("conversations/")
  Future<ConversationResponse> getUnViewedConversations(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User")int user_id,
  @Query("unread")bool unread
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
      @Header("XF-Api-User") int user_id,
      @Query("page") int page,
      @Query("direction")String direction,
      @Query("order") String order,
  );

  @GET("alerts/")
  Future<NotificationResponse> getUnViewedAlerts(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Query("unviewed")bool unread
  );

  @GET("posts/{id}/")
  Future<PostFromNotification> getPostOfAlerts(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Path("id") String content_id
  );

  @POST("threads/")
  @FormUrlEncoded()
  Future<CreateNewThreadResponse> postThread(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Field("node_id")int  node_id,
  @Field("title") String title,
  @Field("message")String message,
  @Field("attachment_key")String attachment_key
  );

  @GET("users/find-email")
 Future<Map<String,UserData>> findUserEmail(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Query("email") String email
  );

  @POST("posts/{id}/react")
  @FormUrlEncoded()
  Future<ReactData> getReaponseOfReact(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Path("id")int post_id,
  @Field("reaction_id")int reaction_id
  );

  @POST("attachments/new-key")
  @FormUrlEncoded()
  Future<Map<String, String>> generateAttachmentKeyForReplyConversation(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Field("context[conversation_id]")int message_id,
  @Field("type")String type
  );

  @MultiPart()
  @POST("attachments/")
 Future<Map<String,AttachmentsData>> postAttachmentFile(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Part(name: "attachment")File file,
  @Part(name:"key") String attachmentKey
  );

  @FormUrlEncoded()
  @POST("conversation-messages/")
 Future<Map<String,bool>> postConversationReply(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Field("conversation_id") int conversation_id,
  @Field("message") String message,
  @Field("attachment_key") String attachment_key
  );


  @POST("attachments/new-key")
  @FormUrlEncoded()
  Future<Map<String, String>> generateAttachmentKeyForPostsOfThreads(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Field("context[thread_id]")int thread_id,
  @Field("type")String type
  );
  @POST("posts/")
  @FormUrlEncoded()
  Future<Map<String,bool>> getResponseOfPostsOfThreadsComments(
      @Header("XF-Api-Key") String api_key,
      @Header("XF-Api-User") int user_id,
      @Field("thread_id") int thread_id,
      @Field("message") String message,
      @Field("attachment_key") String attachment_key
  );


  @POST("attachments/new-key")
  @FormUrlEncoded()
 Future<Map<String, String>> generateAttachmentKeyForUserProfile(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Field("context[profile_user_id]")int profile_user_id,
  @Field("type")String type
  );

  @FormUrlEncoded()
  @POST("profile-posts/")
  Future<Map<String,bool>> getResponseOfProfilePostsOfUpdateStatus(
      @Header("XF-Api-Key") String api_key,
      @Header("XF-Api-User") int user_id,
      @Field("user_id") int profile_user_id,
      @Field("message") String message,
      @Field("attachment_key") String attachment_key
  );

  @POST("profile-posts/{id}/react")
  @FormUrlEncoded()
  Future<ReactData> getResponseOfProfilePostsReact(
      @Header("XF-Api-Key") String api_key,
      @Header("XF-Api-User") int user_id,
      @Path("id")int post_id,
      @Field("reaction_id")int reaction_id
      );

  @POST("profile-post-comments/{id}/react")
  @FormUrlEncoded()
  Future<ReactData> getResponseOfProfilePostsOfCommentsReact(
      @Header("XF-Api-Key") String api_key,
      @Header("XF-Api-User") int user_id,
      @Path("id")int profile_comment_id,
      @Field("reaction_id")int reaction_id
      );

  @POST("conversations/{id}/mark-read")
  Future<Map<String, bool>> markReadConversation(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Path("id") int conversation_id
  );

  @POST("alerts/{id}/mark")
  @FormUrlEncoded()
  Future<Map<String, bool>>  markReadAlerts(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Path("id") int alert_id,
  @Field("read")bool read,
  @Field("viewed")bool viewed,
  );

  @POST("me/avatar")
  @MultiPart()
  Future<LoginResponse> updateUserProfileImage(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Part(name: "avatar")File file
  );


  @GET("users/find-name")
  Future<FilterData> findUserByName(
  @Header("XF-Api-Key") String api_key,
  @Query("username")String username
  );


  @GET("forums/{id}/threads/")
  Future<ThreadResponse> getForumsResponseByFilter(
  @Header("XF-Api-Key") String api_key,
  @Path("id")int node_id,
  @Query("direction") String direction,
  @Query("order")String order,
  @Query("starter_id")int starter_id,
  @Query("last_days")String last_days
  );

  // @POST("posts/{id}/")
  // @FormUrlEncoded()
  // Future<Map<String,bool>> getResponseOfReplyOnPostsOfThreads(
  // @Header("XF-Api-Key") String api_key,
  // @Header("XF-Api-User") int user_id,
  // @Path("id")int post_id,
  // @Field("message") String message,
  // @Field("attachment_key")String attachment_key,
  // );
  //
  // @POST("attachments/new-key")
  // @FormUrlEncoded()
  // Future<Map<String,bool>> generateAttachmentKeyForReplyOnPostsOfThreads(
  // @Header("XF-Api-Key") String api_key,
  // @Header("XF-Api-User") int user_id,
  // @Field("context[post_id]") int post_id,
  // @Field("type")String type,
  // );

  @FormUrlEncoded()
  @POST("profile-post-comments/")
  Future<Map<String,bool>> getResponseOfUserProfilePostsOfComments(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Field("profile_post_id")int profile_post_id,
  @Field("message")String message,
  @Field("attachment_key")String attachment_key,
  );

  @POST("attachments/new-key")
  @FormUrlEncoded()
  Future<Map<String,bool>> generateAttachmentKeyForUserProfilePostsOfComments(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Field("context[profile_post_id]")int profile_post_id,
  @Field("type")String type,
  );

  @DELETE("conversations/{id}/")
  @FormUrlEncoded()
  Future<Map<String,bool>> deleteConversation(
      @Header("XF-Api-Key") String api_key,
      @Header("XF-Api-User") int user_id,
      @Path("id") int conversation_id
      );

  @POST("conversations/{id}/star")
  @FormUrlEncoded()
  Future<Map<String,bool>> starConversation(
      @Header("XF-Api-Key") String api_key,
      @Header("XF-Api-User") int user_id,
      @Path("id") int conversation_id
      );


  @POST("attachments/new-key")
  @FormUrlEncoded()
  Future<Map<String, String>> generateAttachmentKeyForPostOfThread(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Field("context[node_id]")int node_id,
  @Field("type") String type
  );

  @POST("attachments/new-key")
  @FormUrlEncoded()
  Future<Map<String, String>> generateAttachmentKeyForStartConversation(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Field("type")String type
  );

  @POST("conversations/")
  @FormUrlEncoded()
  Future<Map<String, bool>> startNewConversation(
  @Header("XF-Api-Key") String api_key,
  @Header("XF-Api-User") int user_id,
  @Field("recipient_ids[]")  List<int> recipient_ids,
  @Field("title")String title,
  @Field("message")String message,
  @Field("attachment_key") String attachment_key,
  @Field("conversation_open") bool conversation_open,
  @Field("open_invite")bool open_invite,
  );


  @POST("posts/{id}/")
  @FormUrlEncoded()
  Future<Map<String,bool>> updateSpecificPost(
      @Header("XF-Api-Key") String api_key,
      @Header("XF-Api-User") int user_id,
      @Field("message")String message,
      @Field("attachment_key") String attachment_key,
      @Path("id") int post_id,
      );

  @POST("attachments/new-key")
  @FormUrlEncoded()
  Future<Map<String, String>> generateAttachmentKeyForUpdateOfSpecificPost(
      @Header("XF-Api-Key") String api_key,
      @Header("XF-Api-User") int user_id,
      @Field("context[post_id]")int thread_id,
      @Field("type")String type
      );
}
