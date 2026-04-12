import 'dart:ui';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/ambient_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      body: AmbientBackground(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  leading: IconButton(icon: const Icon(Icons.menu, color: AppColors.primary), onPressed: () {}),
                  title: const Text('MELODY', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  actions: [
                    if (isWide) ...[
                      TextButton(onPressed: () {}, child: const Text('Home', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold))),
                      TextButton(onPressed: () {}, child: const Text('Explore', style: TextStyle(color: AppColors.outline))),
                      TextButton(onPressed: () {}, child: const Text('Library', style: TextStyle(color: AppColors.outline))),
                    ],
                    const SizedBox(width: 16),
                    const CircleAvatar(
                      backgroundColor: AppColors.surfaceContainerHighest,
                      backgroundImage: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCuYNhxW94PVo9l_5D4XY_bP_xSRP5vyN8_TgJnDarc7UnyLdbpSKQJ16ZwPqk46tduJLBO0Fg6tB5aVmK5KIgW96eX58yDvd-KJTrVwEgqF7WGTkHMFlDmTCO6MWvsIWx1b4VuH1WFbl-BHqA8pEU6UM581hx8VKa1SEhpfUpUmR5dcUgzmNSLv5NLO87SQm50-VufjzybxuvEBcJp8Vnw5oR3escltrJofLmeVH_fjEV9eeFLUuef8UnDJNbapk9UazqjPG38yjU'),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      
                      // Genre Chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            _buildGenreChip('Jazz', true),
                            const SizedBox(width: 16),
                            _buildGenreChip('Electronic', false),
                            const SizedBox(width: 16),
                            _buildGenreChip('Lo-fi', false),
                            const SizedBox(width: 16),
                            _buildGenreChip('Ambient', false),
                            const SizedBox(width: 16),
                            _buildGenreChip('Neo-Soul', false),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 48),

                      // Hero Playlist Section
                      if (isWide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(flex: 7, child: _buildHeroPlaylist(context)),
                            const SizedBox(width: 32),
                            Expanded(flex: 5, child: _buildMixesGrid(context)),
                          ],
                        )
                      else
                        Column(
                          children: [
                            _buildHeroPlaylist(context),
                            const SizedBox(height: 24),
                            SizedBox(height: 300, child: _buildMixesGrid(context)), // Fixed height for grid in mobile view
                          ],
                        ),

                      const SizedBox(height: 48),

                      // Track List
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Recent Tracks', style: Theme.of(context).textTheme.headlineMedium),
                              const SizedBox(height: 4),
                              Text('Your sonic journey continues here.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant)),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('View All', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      _buildRecentTrack(context, 'Starlight Echoes', 'Lumina Collective', 'Midnight Resonance', '4:22', 'https://lh3.googleusercontent.com/aida-public/AB6AXuBGShai7XM2JvsMK7ZGrlrwxMYYSg8fqQlqMMy9jhWP_g-2aQp9-i4Zdtd9mywKfff4dsbqTa5eLa6466H5bQNTU3ketP--ihfU-d7DD7eSduiVz_IQZIGuebxVPK8p0CrAwY1mcQsEXSBAZXPfRJvaU2d3YO_rSPXDddvOa3xKwDr_giWFeroYZjWGLMVc1ZTBqONxsmmyscxCk-VVV6vUYTjqAPp29h3PpEASS2Dy5xCaAVs9rL75fRZ2B3RptbCDNYPYCh7LWLY'),
                      _buildRecentTrack(context, 'Neon Horizon', 'Synth Weaver', 'Cyber Dreams', '3:15', 'https://lh3.googleusercontent.com/aida-public/AB6AXuDL1yMG-V4wYbX0MLwvBIbiU1xd9rUdBRaMwIns1TePpBZFITzLZZ2JTNIjT6CEtw30niLgEs19YvnkDJSMI-nP-vXya4uAnlwY7fm_ckqneAKTyU_EqaTcoKdRjhdFq4PVPNpoFYNBu9KB2x7bwj9gIXdGjXahDIRlaI71ZqzAaUnUafysQOzvrlWsvaJeQOHlfgVTQdqsecWFYf6QfWx5CwkRirQZpogrFmL7C8cMk_pUOhW67Aszk0edy6LfA1bizqTb0IrWego', isFavorite: true),
                      _buildRecentTrack(context, 'Velvet Silence', 'Mono Drift', 'Soft Textures', '5:40', 'https://lh3.googleusercontent.com/aida-public/AB6AXuBKvAgcgM8307u6axZaaVx_lMHsQqgnncjp85Csw9jsstGeKawnF54y18VfNoQzDDIpTAoqQjUZ3DoDm8JK92TGq_vHA-2DpO6S-bJgekeX-yjkEtlk0cwCL5sxZg34OoYEdxBazjKnGpN3j3iMRiY0l7Rk0MfWSqHOI6UPkfOS8elS_TIbJUFEzJM07hjaDBTxqlntXXx7B4DxfbfG_j8OTRHS34RsFiOh2LLsaiPhp_4r36ATDKKQwSjVMlKa1uBSO9vwjWlqSyg'),
                      _buildRecentTrack(context, 'Urban Pulse', 'The Metronome', 'Concrete Jungle', '2:55', 'https://lh3.googleusercontent.com/aida-public/AB6AXuDy3HYWFR_PMN53L2teCIfi4dI0vQPU1AhNDzZeNGOJ0IXY4N2aCP-zK11gjisVTseVB0FlKg8apIwKfulwaSjwJQPGCL1L50G-JmdXz46UMgZcI2rNjO5x3dvZwu90fYlcQsfU9_uaAphbC1n3YVZdr7xpJuIhg7trUKhKBQ33LHk53rXS6Z3o8V0IH4Fjg4SdtHW1eq2mbuHLqL_Rr4W8KUHiuzZ_tupoQBCFDmq2Rl_NcY6Yyu_AsxwIvMUnDKuTmXYVq10vltY'),

                      const SizedBox(height: 200), // Spacing for player and navbar
                    ]),
                  ),
                ),
              ],
            ),
            
            // Persistent Mini-Player Overlay
            Positioned(
              left: 24,
              right: 24,
              bottom: 120, // above the navbar
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant.withOpacity(0.6),
                      border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Linear progress indicator
                        Container(
                          height: 4,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: 0.33,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [AppColors.primary, AppColors.secondary]),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    image: const DecorationImage(
                                      image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBaR60fGOofQRx7X_zBbOffr30pkw5aeCM0gzaGcC8QZ-bf2glOkkLxmgiEThHEL9IZKz42EIwtG-yhRcy918GfYTuV3tVAVQ9BULY1W6qEht4S9fWcvC62m1fodyH2k2h_fitA9OrvWYcjzlvvXkLA_SmAHgBUDADdnd48uNfafB8F8oRA86aaltw-jzZyKg4t1cNa9nb5VhL_2uNYAQJQ7v08SzzN9NGLmo_z8lyOiXcBpqg2NCxMK7R5Zfou-kWMoKwH4pvDaK0'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Starlight Echoes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    const SizedBox(height: 4),
                                    Text('Lumina Collective', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                            
                            Row(
                              children: [
                                if (isWide) const Icon(Icons.shuffle, color: AppColors.outline),
                                const SizedBox(width: 16),
                                const Icon(Icons.skip_previous, color: AppColors.onSurface),
                                const SizedBox(width: 16),
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                  child: const Icon(Icons.play_arrow, color: AppColors.background, size: 28),
                                ),
                                const SizedBox(width: 16),
                                const Icon(Icons.skip_next, color: AppColors.onSurface),
                                const SizedBox(width: 16),
                                if (isWide) const Icon(Icons.repeat, color: AppColors.outline),
                              ],
                            ),
                            
                            if (isWide)
                              Row(
                                children: [
                                  const Icon(Icons.volume_up, color: AppColors.outline, size: 16),
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 100,
                                    height: 4,
                                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(2)),
                                    alignment: Alignment.centerLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: 0.75,
                                      child: Container(decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.playlist_play, color: AppColors.outline),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? null : AppColors.surfaceContainerHigh,
        gradient: isSelected ? const LinearGradient(colors: [AppColors.primary, AppColors.primaryContainer], begin: Alignment.topLeft, end: Alignment.bottomRight) : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.onPrimaryFixed : AppColors.onSurfaceVariant,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildHeroPlaylist(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDWyQbWNjYT_d-QIJVKWHboi1q2duyXHGt5xc40Pm4Hov2o9UcjGzSJ2dGyC5Kk6AqQ_IC7SVyMFMdSUHbsz3eaPDujTyb_i1wzni5E6pMDi7exco-M7Psw2Bun0sG3X4plSRM6vCdJ6j2TYrTp_lH8Yjx1VHkvn7TJKsJjn4h_j-Xj4_ek_YeqeEHNz_drjBeaxFj1WynVjaZ0ncfrC3b-cZJv_PyO4gKqVg9dhqiS3ud-3QXJASUQgI6VmavbgUpY3M-VCSrYvJ0'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
          ),
        ),
        padding: const EdgeInsets.all(32),
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('FEATURED PLAYLIST', style: TextStyle(color: AppColors.tertiary, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 2)),
            const SizedBox(height: 8),
            Text('Midnight\nResonance', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white, height: 1.1)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow, color: Colors.black),
              label: const Text('Play Now', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMixesGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _buildMixCard('Daily Mix', 'Curated for you', '01'),
        _buildMixCard('Mood Boost', 'Vibrant beats', '02'),
        _buildMixCard('Chill Out', 'Deep focus', '03'),
        _buildMixCard('Jazz Flow', 'Classic soul', '04'),
      ],
    );
  }

  Widget _buildMixCard(String title, String subtitle, String number) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          Positioned(
            top: -20,
            right: -10,
            child: Text(
              number,
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.w900,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: AppColors.outline, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTrack(BuildContext context, String trackName, String artistName, String albumName, String duration, String imageUrl, {bool isFavorite = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent, // add hover effect if needed
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trackName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(artistName, style: const TextStyle(color: AppColors.outline, fontSize: 12)),
              ],
            ),
          ),
          if (MediaQuery.of(context).size.width > 600)
            Expanded(
              flex: 2,
              child: Text(albumName, style: const TextStyle(color: AppColors.outline, fontSize: 12)),
            ),
          Row(
            children: [
              Icon(Icons.favorite, color: isFavorite ? AppColors.primary : AppColors.outline),
              const SizedBox(width: 24),
              Text(duration, style: const TextStyle(color: AppColors.outline, fontSize: 12)),
              const SizedBox(width: 24),
              const Icon(Icons.more_vert, color: AppColors.outline),
            ],
          ),
        ],
      ),
    );
  }
}
