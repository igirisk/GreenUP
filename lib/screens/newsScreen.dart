import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../widgets/bottomNavBar.dart';

class NewsScreen extends StatefulWidget {
  static String routeName = '/news';

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _selectedIndex = 1;
  Dio _dio = Dio();
  List<dynamic> sustainabilityArticles = [];
  bool isLoading = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSustainabilityNews();
  }

  Future<void> fetchSustainabilityNews() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await _dio.get(
        'https://newsapi.org/v2/everything?q=environment%20OR%20climate%20change%20OR%20sustainability&language=en&apiKey=994bff6fdd554032b22cedaeb0dc44dc',
      );

      if (response.statusCode == 200) {
        final jsonData = response.data;
        setState(() {
          sustainabilityArticles = jsonData['articles'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load sustainability news');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load sustainability news: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('News'),
      ),
      body: isLoading
          ? Center(child: const CircularProgressIndicator())
          : ListView.separated(
              itemBuilder: (ctx, i) {
                final article =
                    sustainabilityArticles[i]; // Get the article for this index
                DateTime publishedDate = DateTime.parse(article['publishedAt']);
                String formattedDate =
                    DateFormat('dd MMM yyyy').format(publishedDate);
                return Center(
                  child: Container(
                    width: screenWidth * 0.8,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article['title'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          article['source']['name'],
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 10,
                              color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
                        Text(article['description'] ?? ''),
                        const SizedBox(height: 5),
                        if (article['urlToImage'] != null)
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0)),
                            width: screenWidth * 0.8,
                            child: Image.network(
                              article['urlToImage'],
                            ),
                          ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Spacer(),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, i) => const Divider(
                height: 20,
                color: Colors.transparent,
              ),
              itemCount: sustainabilityArticles.length,
            ),
    );
  }
}
