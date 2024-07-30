import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils.dart';
import '../view_models/comment_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    final commentsViewModel = Provider.of<CommentsViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      commentsViewModel.fetchComments();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Comments',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
        ),
        backgroundColor: const Color(0xFF0C54BE),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Consumer<CommentsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(viewModel.errorMessage));
          } else if (viewModel.comments.isEmpty) {
            return const Center(child: Text('No comments found'));
          } else {
            return ListView.builder(
              itemCount: viewModel.comments.length,
              itemBuilder: (context, index) {
                final comment = viewModel.comments[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFF0C54BE),
                          child: Text(
                            comment.name[0].toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              richText("Name", comment.name),
                              richText("Email", maskEmail(comment.email)),
                              const SizedBox(height: 16),
                              Text(comment.body),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget richText(
      String firstText,
      String secondText
      ){
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$firstText : ",
            style: TextStyle(
              color: isDarkMode? Colors.white:  Colors.black,
              fontStyle: FontStyle.italic,
              fontSize: 14
            ),
          ),
          TextSpan(
            text: secondText,
            style: TextStyle(
              color: isDarkMode? Colors.white:  Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15
            ),
          ),
        ],
      ),
    );
  }
}

