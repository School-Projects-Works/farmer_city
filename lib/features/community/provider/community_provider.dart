import 'package:firmer_city/features/community/data/community_post_model.dart';
import 'package:firmer_city/features/community/services/community_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postStream = StreamProvider<List<PostModel>>((ref) async* {
  var data =  CommunityServices.getPosts();
  
});
