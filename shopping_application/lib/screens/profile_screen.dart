import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(
              Icons.person,
              size: 50,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'john.doe@example.com',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            title: 'Account',
            items: [
              _buildMenuItem(
                icon: Icons.person_outline,
                title: 'Personal Information',
                onTap: () {
                  // TODO: Navigate to personal information
                },
              ),
              _buildMenuItem(
                icon: Icons.shopping_bag_outlined,
                title: 'My Orders',
                onTap: () {
                  // TODO: Navigate to orders
                },
              ),
              _buildMenuItem(
                icon: Icons.favorite_border,
                title: 'Wishlist',
                onTap: () {
                  // TODO: Navigate to wishlist
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            title: 'Settings',
            items: [
              _buildMenuItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                onTap: () {
                  // TODO: Navigate to notifications settings
                },
              ),
              _buildMenuItem(
                icon: Icons.payment_outlined,
                title: 'Payment Methods',
                onTap: () {
                  // TODO: Navigate to payment methods
                },
              ),
              _buildMenuItem(
                icon: Icons.location_on_outlined,
                title: 'Shipping Addresses',
                onTap: () {
                  // TODO: Navigate to shipping addresses
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            title: 'Support',
            items: [
              _buildMenuItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                onTap: () {
                  // TODO: Navigate to help center
                },
              ),
              _buildMenuItem(
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {
                  // TODO: Navigate to about
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement logout
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
} 