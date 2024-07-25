import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/generated/assets.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    var styles = Styles(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            width: styles.isMobile
                ? double.infinity
                : styles.isTablet
                    ? styles.width * .5
                    : styles.width * .4,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Image
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: user.profileImage != null
                            ? NetworkImage(user.profileImage!)
                            : AssetImage(user.gender == 'Male'
                                ? Assets.imagesMale
                                : Assets.imagesFemale) as ImageProvider,
                      ),
                      const SizedBox(height: 20),
                      // Name
                      Text(
                        user.name ?? 'No Name',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Email
                      Text(
                        user.email ?? 'No Email',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Personal Information
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow('Phone', user.phone),
                              _buildInfoRow('Gender', user.gender),
                              _buildInfoRow('User Type', user.userType),
                              _buildInfoRow(
                                  'Created At',
                                  user.createdAt != null
                                      ? DateFormat('EEE,MMM dd, yyyy').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              user.createdAt!))
                                      : null),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Farm Types
                      _buildListCard('Farm Types', user.farmType),
                      const SizedBox(height: 20),
                      // Product Types
                      _buildListCard('Product Types', user.productType),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _buildListCard(String title, List<String> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...items.map((item) => Text('• $item')).toList(),
          ],
        ),
      ),
    );
  }
}
