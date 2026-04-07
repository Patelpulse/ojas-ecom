import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  String _selectedCategory = 'All';

  final List<String> categories = ['All', 'Technology', 'Home & Living', 'Shopping Tips', 'Fashion', 'Kitchen & Cooking', 'Fitness & Health'];

  final List<Map<String, dynamic>> featuredArticles = [
    {
      'category': 'Technology',
      'date': 'Nov 1, 2024',
      'readTime': '8 min read',
      'title': '10 Must-Have Tech Gadgets for 2024',
      'desc': 'Discover the latest technology trends and gadgets that are revolutionizing our daily lives. From smart home devices to cutting-edge wearables.',
      'authorName': 'Sarah Johnson',
      'authorImg': 'https://i.pravatar.cc/150?img=1',
      'views': '1250',
      'comments': '23',
      'img': 'https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    },
    {
      'category': 'Shopping Tips',
      'date': 'Oct 25, 2024',
      'readTime': '5 min read',
      'title': 'The Ultimate Guide to Online Shopping Safety',
      'desc': 'Stay safe while shopping online with these essential tips and best practices for secure e-commerce transactions.',
      'authorName': 'Emma Davis',
      'authorImg': 'https://i.pravatar.cc/150?img=5',
      'views': '2100',
      'comments': '45',
      'img': 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    }
  ];

  final List<Map<String, dynamic>> latestArticles = [
    {
      'category': 'Home & Living',
      'date': 'Oct 20, 2024',
      'readTime': '6 min read',
      'title': 'Home Decor Trends That Will Transform Your Space',
      'desc': 'Explore the latest interior design trends and learn how to create a beautiful, functional living space on any budget.',
      'authorName': 'Michael Chen',
      'authorImg': 'https://i.pravatar.cc/150?img=11',
      'views': '890',
      'comments': '15',
      'img': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    },
    {
      'category': 'Fashion',
      'date': 'Oct 18, 2024',
      'readTime': '7 min read',
      'title': 'Sustainable Fashion: Building an Eco-Friendly Wardrobe',
      'titleColor': const Color(0xFFF01B6B),
      'desc': 'Learn how to make conscious fashion choices that benefit both your style and the environment.',
      'authorName': 'Alex Rodriguez',
      'authorImg': 'https://i.pravatar.cc/150?img=12',
      'views': '1450',
      'comments': '28',
      'img': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    },
    {
      'category': 'Kitchen & Cooking',
      'date': 'Oct 15, 2024',
      'readTime': '9 min read',
      'title': 'Kitchen Essentials Every Home Cook Needs',
      'desc': 'Discover the must-have kitchen tools and appliances that will elevate your cooking game.',
      'authorName': 'Lisa Thompson',
      'authorImg': 'https://i.pravatar.cc/150?img=9',
      'views': '1780',
      'comments': '34',
      'img': 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?auto=format&fit=crop&w=800&q=80',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return OjasLayout(
      activeTitle: 'BLOG',
      child: Container(
        color: const Color(0xFFF8FAFC),
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: CenteredContent(
          horizontalPadding: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Center(
                child: Column(
                  children: [
                    Text(
                      'Our Blog',
                      style: GoogleFonts.outfit(fontSize: 40, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Stay updated with the latest trends, tips, and insights from our experts',
                      style: GoogleFonts.inter(fontSize: 16, color: const Color(0xFF475569)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              // Search and Categories Layout
              Row(
                children: [
                  Container(
                    width: 300,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Color(0xFF94A3B8), size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search articles...',
                              hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 14),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories.map((cat) {
                          bool isActive = cat == _selectedCategory;
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: InkWell(
                              onTap: () => setState(() => _selectedCategory = cat),
                              borderRadius: BorderRadius.circular(24),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isActive ? const Color(0xFFF01B6B) : Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: isActive ? const Color(0xFFF01B6B) : const Color(0xFFE2E8F0)),
                                ),
                                child: Text(
                                  cat,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                                    color: isActive ? Colors.white : const Color(0xFF475569),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),

              // Featured Articles Title
              Text('Featured Articles', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              const SizedBox(height: 24),

              // Featured Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: featuredArticles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  mainAxisExtent: 470,
                ),
                itemBuilder: (context, index) => _BlogCard(article: featuredArticles[index], isFeatured: true),
              ),

              const SizedBox(height: 64),

              // Latest Articles Title
              Text('Latest Articles', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              const SizedBox(height: 24),

              // Latest Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: latestArticles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  mainAxisExtent: 480,
                ),
                itemBuilder: (context, index) => _BlogCard(article: latestArticles[index], isFeatured: false),
              ),
              
              const SizedBox(height: 80),

              // Stay Updated Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                decoration: BoxDecoration(
                  color: const Color(0xFFF01B6B),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      'Stay Updated',
                      style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Subscribe to our newsletter and never miss the latest articles, tips, and exclusive offers.',
                      style: GoogleFonts.inter(fontSize: 16, color: Colors.white.withOpacity(0.9)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 500,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD4105B),
                                borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Enter your email',
                                  hintStyle: GoogleFonts.inter(color: Colors.white.withOpacity(0.6), fontSize: 15),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Text(
                                  'Subscribe',
                                  style: GoogleFonts.inter(color: const Color(0xFFF01B6B), fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward, color: Color(0xFFF01B6B), size: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  final Map<String, dynamic> article;
  final bool isFeatured;

  const _BlogCard({required this.article, required this.isFeatured});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Area
          SizedBox(
            height: isFeatured ? 240 : 210,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  article['img'], 
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
                  ),
                ),
                if (isFeatured)
                  Positioned(
                    top: 16, left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF01B6B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Featured', style: GoogleFonts.inter(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ),
                Positioned(
                  top: 16, right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.favorite_border, size: 16, color: Color(0xFF64748B)),
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(article['category'], style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF475569), fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.calendar_today_outlined, size: 14, color: const Color(0xFF94A3B8)),
                      const SizedBox(width: 6),
                      Text(article['date'], style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time, size: 14, color: const Color(0xFF94A3B8)),
                      const SizedBox(width: 6),
                      Text(article['readTime'], style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    article['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: isFeatured ? 20 : 18, 
                      fontWeight: FontWeight.bold, 
                      color: article['titleColor'] ?? const Color(0xFF0F172A),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    article['desc'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF64748B), height: 1.5),
                  ),
                  const Spacer(),
                  const Divider(color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(backgroundImage: NetworkImage(article['authorImg']), radius: 12),
                          const SizedBox(width: 8),
                          Text(article['authorName'], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.remove_red_eye_outlined, size: 14, color: const Color(0xFF94A3B8)),
                          const SizedBox(width: 4),
                          Text(article['views'], style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                          const SizedBox(width: 12),
                          Icon(Icons.chat_bubble_outline, size: 14, color: const Color(0xFF94A3B8)),
                          const SizedBox(width: 4),
                          Text(article['comments'], style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
