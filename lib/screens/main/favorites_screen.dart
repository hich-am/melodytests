import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/ambient_background.dart';
import '../../widgets/glass_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      body: AmbientBackground(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              pinned: true,
              leading: IconButton(icon: const Icon(Icons.menu, color: AppColors.primary), onPressed: () {}),
              title: const Text('MELODY', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, letterSpacing: 2)),
              actions: [
                if (isWide) const Center(child: Text('Favorites', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold))),
                const SizedBox(width: 24),
                const CircleAvatar(
                  backgroundColor: AppColors.surfaceContainerHighest,
                  backgroundImage: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBvZfVA1CR3-w7dNtU2wXcxRaOoPdjp1FlWAZO6kQw5UkT5VREof2lB68gshy_RUqdVrqTidz6SZOXa2xFG8t9stpX0wpT140BrSpZIo0oJVdfXjbe9_VKQJRJTP4KCjtFQc6pkRWcZFC3YRGb-zo93b0NHAXmvtrwljLnApABg8VHmYjwwuXarg_Q5ngeUGnzomOUq3RnLYmE4wNDj1TwblDuFsT-1OGeuOqpiC5aNmH0WF2CbSzWHqncaWb3ZRsVIQdV03drYbc4'),
                ),
                const SizedBox(width: 24),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  
                  // Header section
                  Flex(
                    direction: isWide ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: isWide ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('YOUR COLLECTION', style: TextStyle(color: AppColors.secondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
                          const SizedBox(height: 8),
                          Text('Favorites', style: Theme.of(context).textTheme.displayLarge),
                        ],
                      ),
                      if (!isWide) const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.outlineVariant.withOpacity(0.15)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.fingerprint, color: AppColors.primary),
                            const SizedBox(width: 12),
                            Text('Biometric auth required\nfor track removal', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
                          ],
                        ),
                      )
                    ],
                  ),
                  
                  const SizedBox(height: 48),

                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _buildTrackList(context)),
                        const SizedBox(width: 32),
                        Expanded(flex: 1, child: _buildStatsSidebar(context)),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildTrackList(context),
                        const SizedBox(height: 48),
                        _buildStatsSidebar(context),
                      ],
                    ),

                  const SizedBox(height: 120), // nav bar padding
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackList(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(flex: 2, child: Text('TRACK', style: TextStyle(color: AppColors.outline, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2))),
            if (MediaQuery.of(context).size.width > 600)
              const Expanded(flex: 1, child: Text('ALBUM', style: TextStyle(color: AppColors.outline, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2))),
            const Text('DURATION', style: TextStyle(color: AppColors.outline, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(width: 48), // Padding for delete icon space
          ],
        ),
        const SizedBox(height: 16),
        _buildTrackItem(context, 'Neon Echoes', 'Solaris Drift', 'Cybernetic Dreams', '03:42', 'https://lh3.googleusercontent.com/aida-public/AB6AXuCQrviwKBcxX07q4ddg5thBRmsFpWOLyD4Mg3gmBDZpg800GJvfLHywa5WvtW4RK5UedVm34lXQjxQmizvRzW-Zq2e8L4sFHh-Ofpc4omHgcb7webuZbSzHifJVXSgkwuv4IuwfnSYTamNR3CVbdeyYMJYCqK6oLYgsJq73YXGPBWRNo8oyk4IkfyvtTAMGstJ-GxKD2dGVEWE77qOKnZeu8bk5Fy61JH3OBXkRz-EeBN3ur8rqTWtXZlWSEcZsRDGYZF51lMyWAww'),
        _buildTrackItem(context, 'Midnight Rain', 'Luna Ray', 'After Hours', '04:15', 'https://lh3.googleusercontent.com/aida-public/AB6AXuCa7fdnPLapq5qxCSaOnkECqib0KGHdrmHQDtrvtXrR1DijQhojQN_Ndp6tF-zdHqdY4JCtZbVsRZojLW5utiUIGlnef0yymJRRZmHD0chTBx9i952sIvVDD3aMnqPFlQFnjzdxOAysqIv2YjqXLJFXKilHbto8bp57Xt-W2OSP6QuaJme1YkIPXniRx_vXb9-NddfMKPXtpoSSKEu_fcFK_C5FS2XP_s35nufjp3popb8hFdNoe8bifpV0sqBUku0ngRXz3teE-sw'),
        _buildTrackItem(context, 'Velvet Sky', 'The Orchids', 'Botanical Beats', '02:58', 'https://lh3.googleusercontent.com/aida-public/AB6AXuBaHMYbT47xRFIAYO_fKSqsMqfVJuAJv8KX6w3eDgopU-Zcnxoyz2hATESDeM6smlQRi7PULiN9UoZTk4fea24yjBtqrY2AsTHILHZ83J4OWNwnxcKrrPBrMG0ezbkKzUWuwDp3AJbSU17Myt9y5ambFI6Il1zmTLPYsd_FpouA6uxFs6gIQVTZlycaIjX_Z29WyoMQnXStUYd3M2jLFWSmYi8nv6pNmzNHo9Dysr3J00yN4Gp1YnazII1lr3sbM0ahbGzSwrUeGis'),
        _buildTrackItem(context, 'Static Pulse', 'Frequency X', 'Signal Loss', '05:22', 'https://lh3.googleusercontent.com/aida-public/AB6AXuAAtTiaw1hnSyjd4BfCsq5zCoNcnpJdGAcbTxICOtv76zf7g5J_X4EyHO1FdoDAtsPu67ve6bI5JSoPGQQ2-x6RdVHN9N-lzy-YPrWkgz-HCDhxB1H3zb0tGj0ed1oWAhzcsYkC24IZgwiIUBMKI93_8w0j5g8LdRbWTOFM8KJePs8Hc_6X1Ecs3DWMmTMqNqSejG3tdOXBa0fb4UZsjMK5qapuF-losvqvHquSfic3NHYfQfNkYVQhVF6Sxo9N8Dc2tBUSnMkcPaQ'),
      ],
    );
  }

  Widget _buildTrackItem(BuildContext context, String trackName, String artistName, String albumName, String duration, String imageUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trackName, style: Theme.of(context).textTheme.titleMedium, overflow: TextOverflow.ellipsis),
                      Text(artistName, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant), overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (MediaQuery.of(context).size.width > 600)
            Expanded(
              flex: 1,
              child: Text(albumName, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant, fontStyle: FontStyle.italic)),
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(duration, style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(width: 24),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.outline),
                onPressed: () {},
                hoverColor: AppColors.error.withOpacity(0.1),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatsSidebar(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Playlist Stats', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text('Curated over 6 months', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
          const SizedBox(height: 32),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Tracks', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant)),
              Text('128', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Listening Time', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant)),
              Text('8h 42m', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary)),
            ],
          ),
          
          const SizedBox(height: 32),
          const Divider(color: AppColors.outlineVariant),
          const SizedBox(height: 32),
          
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryContainer]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shuffle, color: AppColors.onPrimaryFixed),
              label: const Text('Shuffle Collection', style: TextStyle(color: AppColors.onPrimaryFixed, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
          
          const SizedBox(height: 48),
          Text('SECURITY NOTICE', style: TextStyle(color: AppColors.secondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.surfaceContainerLowest, borderRadius: BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.verified_user, color: AppColors.tertiary),
                const SizedBox(width: 12),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant),
                      children: const [
                        TextSpan(text: 'To protect your curated collection, deleting any track requires active '),
                        TextSpan(text: 'Fingerprint Authentication', style: TextStyle(color: AppColors.onSurface, fontWeight: FontWeight.bold)),
                        TextSpan(text: '. Ensure your device sensor is clean.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
