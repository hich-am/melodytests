import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/ambient_background.dart';
import '../../widgets/glass_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                const CircleAvatar(
                  backgroundColor: AppColors.surfaceContainerHighest,
                  backgroundImage: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuD2RUf0361taIWjap8pCT6E9xx_aPCETtzPol369lfjNcA-cgOMVGcJFkU7R7cNKPR0U28Yfy-xSZI2yWO32Sukd7lBT4q2-kXnQQ0Qo9ZKtbyFuPOhpKEkKPbSZn8iPLxfOiQEOLlLowfTG6-38AUKi0k860xkkLCNP7ULg9aigjg0KsjKB3It2166Ods4-JM4NNVUkbcJzqMNgY8occF9FiK0KTFaVASMo_98dTU_eYqmcMQAL0bK9xLZeSv4Fk5erAybwrjH5e0'),
                ),
                const SizedBox(width: 24),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  Text('Hello, User', style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 8),
                  Text('Ready for your daily soundscape?', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: 48),

                  // Stats Grid Let's make it responsive
                  if (MediaQuery.of(context).size.width > 800)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 1, child: _buildListeningTimeCard(context)),
                        const SizedBox(width: 24),
                        Expanded(flex: 2, child: _buildActivityChartCard(context)),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildListeningTimeCard(context),
                        const SizedBox(height: 24),
                        _buildActivityChartCard(context),
                      ],
                    ),
                  
                  const SizedBox(height: 24),
                  _buildGoalCard(context),

                  const SizedBox(height: 48),
                  
                  // Most played tracks
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Most Played Tracks', style: Theme.of(context).textTheme.headlineMedium),
                      TextButton(onPressed: () {}, child: const Text('SEE ALL', style: TextStyle(color: AppColors.primary, letterSpacing: 2, fontSize: 12))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  GridView.count(
                    crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 0.8,
                    children: [
                      _buildTrackCard(context, 'Neon Horizons', 'Synthetic Dreams', 'https://lh3.googleusercontent.com/aida-public/AB6AXuDaNXaYwehMaRH37dG9A05zZXLOgbYIZZzndIqiEHBsv3ojVtgT75ajEbJ6CZf-Z92aC4FUEZYCRJ5gNm4GEkQpQYYp-ZZRppRZ7Kplrbj-O-zOXghLHcUau75Zfs61-NC0vVc95_MMGH4G5I6R5r9sCfsEBKsbN7pgTBOqDKQvfVLIbWUePWcM2OOQGtognm0UQf9_A4lOt-_xZ09552Hj7nAWgk0z8HH_6sYof5Y3NvZFAbIsj2VzzRz59VWiVSOIh43GU_wH1Bk'),
                      _buildTrackCard(context, 'After Hours', 'Midnight Pulse', 'https://lh3.googleusercontent.com/aida-public/AB6AXuAcS1moSND8JNo1FtLo8MS54XtKKvc9o44UXSsioWBJaiIO7qAWZW5zbT-V4WQbiYViuMUwegJ1IPNguH6e097hUQQwWGJJoGOJH3sKk1EaFi5iXbRwjkhswX5zgxeoCQ0g1LBHIU5boHrvellvxgHP2BlHEgA9LISfOD3gXOgiX_Tq1ASomrythgyZzRzmzhUIlqcgweySeUH3R2PAvM_OteDhBi577xA6Ctvo4EUsBEDGhSs5Jo6sEVw_6mRP1kqjpcc33Pwswp8'),
                      _buildTrackCard(context, 'Electric Sky', 'Velocity X', 'https://lh3.googleusercontent.com/aida-public/AB6AXuDu0iXD-IYIwGpQN2lSawaLSyI-DlXhR7f1tolR8brQ_99iDVCv069bVi5v4Ih2r7hVlWGoUqc32ZgBcLtYZOtMWlCi_GFr4k7y9noRVddq9rFKLkS9KFPG5BdR9SBWXlXj0R4i8brbBg1G6uzQgAx-uB4k9XuP2wb0bNns0jNsW6e_wdXSuFmhG3MOkyf5Hb7P-hmdk6Fs9CFjIr_v3SZvEiELea6gLWRy00BR5oBDNyQl8EQ01yLlB47jEGsDWa7bxhrzYcB9I04'),
                      _buildTrackCard(context, 'Subliminal', 'The Low-Fi Project', 'https://lh3.googleusercontent.com/aida-public/AB6AXuAu8DW19cA_IO2b7A38wIqOPEiJqAKhZ9kAjReTWT7jk3gOrfbsHHN3jLZZYA0T1V2SKr4Gj_9YxXtbZFuLxQ4j3mSqBF9Bg2sJhRzZkg4tO1CbX7X2utxBUZA-6DXxg21xov1bCXKvk5qfP_w97hA4Dv6PbWqxxFv5KeSfV2WEPNmeRFZ9SihqX0xk2Qfrt0onehE3wsljx8_Tw1bQHQYxlP5AJp_WtWcB69pfm2wXkMPOglHOT1MsgkntO_f49fvDfsXasGtsthw'),
                    ],
                  ),
                  
                  const SizedBox(height: 120), // Bottom padding for nav bar
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListeningTimeCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TOTAL LISTENING TIME', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.primary)),
              const Icon(Icons.schedule, color: AppColors.outlineVariant, size: 48),
            ],
          ),
          const SizedBox(height: 16),
          Text('42h', style: Theme.of(context).textTheme.displayMedium),
          const Spacer(),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.trending_up, color: AppColors.secondary, size: 16),
              const SizedBox(width: 8),
              Text('+12% from last week', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.secondary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityChartCard(BuildContext context) {
    // Dummy heights for histogram
    final heights = [0.4, 0.6, 0.45, 0.8, 0.95, 0.7, 0.55, 0.4, 0.65, 0.85, 1.0, 0.6];
    
    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Activity', style: Theme.of(context).textTheme.headlineSmall),
              Text('LAST 30 DAYS', style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(heights.length, (index) {
                final isPeak = heights[index] > 0.9;
                return Container(
                  width: 12, // simple fixed width for dummy chart
                  height: 120 * heights[index],
                  decoration: BoxDecoration(
                    color: isPeak ? AppColors.primary : AppColors.surfaceContainerHighest,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Flex(
        direction: MediaQuery.of(context).size.width > 600 ? Axis.horizontal : Axis.vertical,
        children: [
          Expanded(
            flex: MediaQuery.of(context).size.width > 600 ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Monthly Listening Goal', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 4),
                Text("You're crushing your 60h target!", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width > 600 ? 0 : 24, width: 24),
          Expanded(
            flex: MediaQuery.of(context).size.width > 600 ? 2 : 0,
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.centerLeft,
              child: Container(
                width: 250, // Static width since it's a dummy
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.primary, AppColors.secondary]),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width > 600 ? 0 : 24, width: 24),
          Text('70%', style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }

  Widget _buildTrackCard(BuildContext context, String title, String subtitle, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
      ],
    );
  }
}
