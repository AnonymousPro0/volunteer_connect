import 'package:flutter/material.dart';

void main() {
  runApp(const VolunteerConnectApp());
}

class VolunteerConnectApp extends StatelessWidget {
  const VolunteerConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth.clamp(0.0, 390.0)
            : 390.0;
        final height = constraints.maxHeight.isFinite
            ? constraints.maxHeight.clamp(0.0, 844.0)
            : 844.0;

        return Center(
          child: SizedBox(
            width: width,
            height: height,
            child: MaterialApp(
              title: 'VolunteerConnect',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.teal,
                  brightness: Brightness.light,
                ),
                useMaterial3: true,
              ),
              home: const MainNavigationScreen(),
            ),
          ),
        );
      },
    );
  }
}

class VolunteerOpportunity {
  final String id;
  final String title;
  final String description;
  final String location;
  final String duration;
  final String tag;
  final String matchScore;

  const VolunteerOpportunity({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.duration,
    required this.tag,
    this.matchScore = '',
  });
}

const List<VolunteerOpportunity> localDhanbadData = [
  VolunteerOpportunity(
    id: '1',
    title: 'Campus Plantation Drive',
    description: 'Help plant 50 saplings near the ISM campus pond area.',
    location: 'IIT (ISM) Dhanbad Campus',
    duration: '2 Hours',
    tag: 'Environment',
    matchScore: '95% Match',
  ),
  VolunteerOpportunity(
    id: '2',
    title: 'Weekend Slum Education',
    description: 'Teach basic mathematics and English to underprivileged children.',
    location: 'Steel Gate, Dhanbad',
    duration: '3 Hours',
    tag: 'Teaching',
    matchScore: '92% Match',
  ),
  VolunteerOpportunity(
    id: '3',
    title: 'Stray Animal Feeding Network',
    description: 'Distribute food and check the health of street animals.',
    location: 'Saraidhela, Dhanbad',
    duration: '2 Hours',
    tag: 'Animal Care',
    matchScore: '88% Match',
  ),
  VolunteerOpportunity(
    id: '4',
    title: 'Cyber Security Awareness Camp',
    description: 'Explain digital banking safety to local senior citizens.',
    location: 'Bank More, Dhanbad',
    duration: '4 Hours',
    tag: 'Tech',
    matchScore: '98% Match',
  ),
  VolunteerOpportunity(
    id: '5',
    title: 'Blood Donation Camp Assistant',
    description: 'Manage donor registrations and distribute refreshments.',
    location: 'SNMMCH Hospital, Dhanbad',
    duration: '5 Hours',
    tag: 'Medical',
  ),
  VolunteerOpportunity(
    id: '6',
    title: 'Dhanbad Junction Literacy Walk',
    description: 'Distribute basic learning kits and books to children near the station.',
    location: 'Dhanbad Railway Station',
    duration: '3 Hours',
    tag: 'Teaching',
  ),
  VolunteerOpportunity(
    id: '7',
    title: 'Lake Cleanup & Plastic Removal',
    description: 'Help remove floating plastic debris from the local lake.',
    location: 'Maithon Dam Site',
    duration: '4 Hours',
    tag: 'Environment',
  ),
  VolunteerOpportunity(
    id: '8',
    title: 'Free Health Checkup Assistant',
    description: 'Help doctors manage queues and distribute basic medicines.',
    location: 'Jharia, Dhanbad',
    duration: '6 Hours',
    tag: 'Medical',
  ),
  VolunteerOpportunity(
    id: '9',
    title: 'Traffic Awareness Volunteering',
    description: 'Distribute road-safety flyers with traffic management officers.',
    location: 'Randhir Verma Chowk, Dhanbad',
    duration: '2 Hours',
    tag: 'Community',
  ),
  VolunteerOpportunity(
    id: '10',
    title: 'Digital Literacy Workshop',
    description: 'Teach smartphone basics and UPI safety to local street vendors.',
    location: 'Purana Bazar, Dhanbad',
    duration: '3 Hours',
    tag: 'Tech',
    matchScore: '90% Match',
  ),
  VolunteerOpportunity(
    id: '11',
    title: 'Orphanage Festival Celebration',
    description: 'Organize drawing competitions and games for children.',
    location: 'Katras, Dhanbad',
    duration: '4 Hours',
    tag: 'Teaching',
  ),
  VolunteerOpportunity(
    id: '12',
    title: 'Cloth Distribution Drive',
    description: 'Sort and distribute winter blankets and clothes.',
    location: 'Chirkunda, Dhanbad',
    duration: '3 Hours',
    tag: 'Community',
  ),
  VolunteerOpportunity(
    id: '13',
    title: 'Anti-Plastic Shop Awareness',
    description: 'Give cloth bags to local vendors to discourage plastic use.',
    location: 'Lindsay Club Road, Dhanbad',
    duration: '2 Hours',
    tag: 'Environment',
  ),
  VolunteerOpportunity(
    id: '14',
    title: 'First Aid Basics Training',
    description: 'Set up a community emergency training session.',
    location: 'Govindpur, Dhanbad',
    duration: '4 Hours',
    tag: 'Medical',
  ),
  VolunteerOpportunity(
    id: '15',
    title: 'Community Library Setup',
    description: 'Catalog and arrange donated books on library shelves.',
    location: 'Hirapur, Dhanbad',
    duration: '5 Hours',
    tag: 'Education',
  ),
];

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  final Set<String> _joinedOpportunityIds = <String>{};

  List<VolunteerOpportunity> get _joinedOpportunities =>
      localDhanbadData
          .where((opportunity) => _joinedOpportunityIds.contains(opportunity.id))
          .toList();

  void _toggleJoined(VolunteerOpportunity opportunity) {
    setState(() {
      if (!_joinedOpportunityIds.add(opportunity.id)) {
        _joinedOpportunityIds.remove(opportunity.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            joinedOpportunityIds: _joinedOpportunityIds,
            onToggleJoined: _toggleJoined,
          ),
          RecommendationsScreen(
            joinedOpportunityIds: _joinedOpportunityIds,
            onToggleJoined: _toggleJoined,
          ),
          DashboardScreen(
            joinedOpportunities: _joinedOpportunities,
            onLeaveOpportunity: _toggleJoined,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.psychology_outlined),
            selectedIcon: Icon(Icons.psychology),
            label: 'AI Matches',
          ),
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Set<String> joinedOpportunityIds;
  final ValueChanged<VolunteerOpportunity> onToggleJoined;

  const HomeScreen({
    required this.joinedOpportunityIds,
    required this.onToggleJoined,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<String> _filters = [
    'All',
    'Environment',
    'Teaching',
    'Tech',
    'Medical',
    'Community',
    'Animal Care',
    'Education',
  ];

  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = _searchQuery.trim().toLowerCase();
    final filteredOpportunities = localDhanbadData.where((opportunity) {
      final matchesFilter =
          _selectedFilter == 'All' || opportunity.tag == _selectedFilter;
      final searchableText = [
        opportunity.title,
        opportunity.description,
        opportunity.location,
        opportunity.tag,
      ].join(' ').toLowerCase();
      return matchesFilter && searchableText.contains(normalizedQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VolunteerConnect',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search volunteer opportunities',
              leading: const Icon(Icons.search),
              trailing: [
                if (_searchQuery.isNotEmpty)
                  IconButton(
                    tooltip: 'Clear search',
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                  ),
              ],
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              children: [
                for (final filter in _filters)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: _selectedFilter == filter,
                      onSelected: (_) =>
                          setState(() => _selectedFilter = filter),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: filteredOpportunities.isEmpty
                ? const Center(
                    child: Text('No opportunities match your search.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredOpportunities.length,
                    itemBuilder: (context, index) {
                      final opportunity = filteredOpportunities[index];
                      return OpportunityCard(
                        opportunity: opportunity,
                        isJoined: widget.joinedOpportunityIds
                            .contains(opportunity.id),
                        onToggleJoined: () =>
                            widget.onToggleJoined(opportunity),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class RecommendationsScreen extends StatelessWidget {
  final Set<String> joinedOpportunityIds;
  final ValueChanged<VolunteerOpportunity> onToggleJoined;

  const RecommendationsScreen({
    required this.joinedOpportunityIds,
    required this.onToggleJoined,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final recommendations = localDhanbadData
        .where((opportunity) => opportunity.matchScore.isNotEmpty)
        .toList()
      ..sort(
        (first, second) => _matchPercentage(second.matchScore).compareTo(
          _matchPercentage(first.matchScore),
        ),
      );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Best Matches',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Explore opportunities matched to your interests.',
                    ),
                  ),
                ],
              ),
            ),
          ),
          for (final opportunity in recommendations)
            OpportunityCard(
              opportunity: opportunity,
              isJoined: joinedOpportunityIds.contains(opportunity.id),
              onToggleJoined: () => onToggleJoined(opportunity),
            ),
        ],
      ),
    );
  }
}

int _matchPercentage(String matchScore) {
  return int.tryParse(matchScore.split('%').first) ?? 0;
}

class DashboardScreen extends StatelessWidget {
  final List<VolunteerOpportunity> joinedOpportunities;
  final ValueChanged<VolunteerOpportunity> onLeaveOpportunity;

  const DashboardScreen({
    required this.joinedOpportunities,
    required this.onLeaveOpportunity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: joinedOpportunities.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.volunteer_activism, size: 48),
                    SizedBox(height: 12),
                    Text(
                      'You have not joined an opportunity yet.',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Explore opportunities and tap Join to get started.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.event_available),
                    title: const Text('Your commitments'),
                    subtitle: Text(
                      '${joinedOpportunities.length} '
                      '${joinedOpportunities.length == 1 ? 'opportunity' : 'opportunities'} joined',
                    ),
                  ),
                ),
                for (final opportunity in joinedOpportunities)
                  OpportunityCard(
                    opportunity: opportunity,
                    isJoined: true,
                    onToggleJoined: () => onLeaveOpportunity(opportunity),
                  ),
              ],
            ),
    );
  }
}

class OpportunityCard extends StatelessWidget {
  final VolunteerOpportunity opportunity;
  final bool isJoined;
  final VoidCallback onToggleJoined;

  const OpportunityCard({
    required this.opportunity,
    required this.isJoined,
    required this.onToggleJoined,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    opportunity.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                if (opportunity.matchScore.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Text(
                    opportunity.matchScore,
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Text(opportunity.description),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _OpportunityDetail(
                  icon: Icons.location_on_outlined,
                  label: opportunity.location,
                ),
                _OpportunityDetail(
                  icon: Icons.schedule,
                  label: opportunity.duration,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Chip(
                  label: Text(opportunity.tag),
                  visualDensity: VisualDensity.compact,
                ),
                const Spacer(),
                FilledButton.tonal(
                  onPressed: onToggleJoined,
                  child: Text(isJoined ? 'Joined' : 'Join'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OpportunityDetail extends StatelessWidget {
  final IconData icon;
  final String label;

  const _OpportunityDetail({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 4),
        Flexible(child: Text(label)),
      ],
    );
  }
}
