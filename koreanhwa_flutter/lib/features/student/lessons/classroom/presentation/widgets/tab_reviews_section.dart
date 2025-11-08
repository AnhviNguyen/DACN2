import 'package:flutter/material.dart';

class CommentItem {
  const CommentItem({
    required this.id,
    required this.user,
    required this.avatar,
    required this.rating,
    required this.date,
    required this.content,
    required this.likes,
    required this.dislikes,
    required this.isMyComment,
  });

  final int id;
  final String user;
  final String avatar;
  final int rating; // 1-5
  final String date;
  final String content;
  final int likes;
  final int dislikes;
  final bool isMyComment;
}

class TabReviewsSection extends StatefulWidget {
  const TabReviewsSection({super.key});

  @override
  State<TabReviewsSection> createState() => _TabReviewsSectionState();
}

class _TabReviewsSectionState extends State<TabReviewsSection> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _editController = TextEditingController();
  int? _editingCommentId;
  int _selectedRating = 5;

  // Mock data - sẽ được thay thế bằng data từ API/provider sau
  final List<CommentItem> _comments = [
    const CommentItem(
      id: 1,
      user: "Nguyễn Văn A",
      avatar: "A",
      rating: 5,
      date: "2025-01-15",
      content:
          "Khóa học rất hay và bổ ích! Giảng viên giải thích rất dễ hiểu, các bài tập thực hành phong phú. Tôi đã cải thiện đáng kể kỹ năng tiếng Hàn sau khi học khóa này.",
      likes: 12,
      dislikes: 0,
      isMyComment: false,
    ),
    const CommentItem(
      id: 2,
      user: "Trần Thị B",
      avatar: "B",
      rating: 5,
      date: "2025-01-10",
      content:
          "Nội dung khóa học được cấu trúc rất logic, từ cơ bản đến nâng cao. Đặc biệt là phần luyện thi TOPIK rất hữu ích cho tôi.",
      likes: 8,
      dislikes: 1,
      isMyComment: true,
    ),
    const CommentItem(
      id: 3,
      user: "Lê Minh C",
      avatar: "C",
      rating: 4,
      date: "2025-01-08",
      content:
          "Khóa học tốt, tài liệu phong phú. Tuy nhiên tôi mong muốn có thêm nhiều bài tập thực hành hơn.",
      likes: 5,
      dislikes: 0,
      isMyComment: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _commentController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _editController.dispose();
    super.dispose();
  }

  void _handleAddComment() {
    if (_commentController.text.trim().isEmpty) return;

    setState(() {
      _comments.insert(
        0,
        CommentItem(
          id: DateTime.now().millisecondsSinceEpoch,
          user: "Bạn",
          avatar: "U",
          rating: _selectedRating,
          date: DateTime.now().toString().split(' ')[0],
          content: _commentController.text,
          likes: 0,
          dislikes: 0,
          isMyComment: true,
        ),
      );
      _commentController.clear();
    });
  }

  void _handleEditComment(int id) {
    final comment = _comments.firstWhere((c) => c.id == id);
    setState(() {
      _editingCommentId = id;
      _editController.text = comment.content;
    });
  }

  void _handleSaveEdit(int id) {
    setState(() {
      final index = _comments.indexWhere((c) => c.id == id);
      if (index != -1) {
        _comments[index] = CommentItem(
          id: _comments[index].id,
          user: _comments[index].user,
          avatar: _comments[index].avatar,
          rating: _comments[index].rating,
          date: _comments[index].date,
          content: _editController.text,
          likes: _comments[index].likes,
          dislikes: _comments[index].dislikes,
          isMyComment: _comments[index].isMyComment,
        );
      }
      _editingCommentId = null;
      _editController.clear();
    });
  }

  void _handleDeleteComment(int id) {
    setState(() {
      _comments.removeWhere((c) => c.id == id);
    });
  }

  void _handleLikeComment(int id) {
    setState(() {
      final index = _comments.indexWhere((c) => c.id == id);
      if (index != -1) {
        _comments[index] = CommentItem(
          id: _comments[index].id,
          user: _comments[index].user,
          avatar: _comments[index].avatar,
          rating: _comments[index].rating,
          date: _comments[index].date,
          content: _comments[index].content,
          likes: _comments[index].likes + 1,
          dislikes: _comments[index].dislikes,
          isMyComment: _comments[index].isMyComment,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        // Form viết đánh giá
        _buildAddCommentForm(context, theme),
        const SizedBox(height: 24),
        // Danh sách comments
        ..._comments.map((comment) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildCommentItem(context, theme, comment),
            )),
      ],
    );
  }

  Widget _buildAddCommentForm(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Viết đánh giá của bạn',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          // Rating stars
          Row(
            children: [
              Text(
                'Đánh giá:',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 8),
              ...List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRating = index + 1;
                    });
                  },
                  child: Icon(
                    Icons.star,
                    size: 20,
                    color: index < _selectedRating
                        ? Colors.amber.shade400
                        : Colors.grey.shade300,
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 16),
          // Textarea
          TextField(
            controller: _commentController,
            maxLines: 4,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Chia sẻ trải nghiệm của bạn về khóa học này...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.amber.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.amber.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.amber.shade500, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Submit button
          ElevatedButton.icon(
            onPressed: _commentController.text.trim().isEmpty
                ? null
                : _handleAddComment,
            icon: const Icon(Icons.send, size: 16),
            label: const Text('Gửi đánh giá'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(
      BuildContext context, ThemeData theme, CommentItem comment) {
    final isEditing = _editingCommentId == comment.id;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.amber.shade400,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                comment.avatar,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: User, rating, date, actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              comment.user,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ...List.generate(5, (index) => Icon(
                                Icons.star,
                                size: 16,
                                color: index < comment.rating
                                    ? Colors.amber.shade400
                                    : Colors.grey.shade300,
                              )),
                          const SizedBox(width: 8),
                          Text(
                            comment.date,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (comment.isMyComment && !isEditing)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, size: 18),
                            color: Colors.grey.shade500,
                            onPressed: () => _handleEditComment(comment.id),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, size: 18),
                            color: Colors.grey.shade500,
                            onPressed: () => _handleDeleteComment(comment.id),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                // Content or edit form
                if (isEditing)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _editController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.amber.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.amber.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.amber.shade500, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => _handleSaveEdit(comment.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber.shade400,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Lưu'),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _editingCommentId = null;
                                _editController.clear();
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Hủy'),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.content,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Like/Dislike buttons
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: () => _handleLikeComment(comment.id),
                            icon: Icon(Icons.thumb_up, size: 16),
                            label: Text('${comment.likes}'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.grey.shade500,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.thumb_down, size: 16),
                            label: Text('${comment.dislikes}'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.grey.shade500,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

