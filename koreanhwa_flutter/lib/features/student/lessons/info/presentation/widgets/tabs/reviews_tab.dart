import 'package:flutter/material.dart';

class ReviewItem {
  const ReviewItem({
    required this.studentName,
    required this.initial,
    required this.rating,
    required this.comment,
  });

  final String studentName;
  final String initial;
  final int rating; // 1-5
  final String comment;
}

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  // Mock data - sẽ được thay thế bằng data từ API/provider sau
  static const _averageRating = 5.0;
  static const _totalReviews = 2;
  static const _reviews = [
    ReviewItem(
      studentName: 'Học viên A',
      initial: 'H',
      rating: 5,
      comment:
          'Khóa học rất hay, giảng viên nhiệt tình. Tôi đã đạt TOPIK II level 5 sau khi học xong khóa này!',
    ),
    ReviewItem(
      studentName: 'Học viên B',
      initial: 'M',
      rating: 5,
      comment:
          'Nội dung chi tiết, bài tập phong phú. Đặc biệt là phần IBT MockTest rất hữu ích!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              // Header với tiêu đề và rating tổng
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Đánh giá từ học viên',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 5 sao
                      ...List.generate(5, (index) => Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.amber.shade400,
                          )),
                      const SizedBox(width: 8),
                      Text(
                        '$_averageRating',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '($_totalReviews đánh giá)',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Danh sách reviews
              ..._reviews.asMap().entries.map((entry) {
                final index = entry.key;
                final review = entry.value;
                final isLast = index == _reviews.length - 1;

                return Column(
                  children: [
                    _buildReviewItem(context, review),
                    if (!isLast) ...[
                      const SizedBox(height: 16),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.shade200,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                );
              }),
      ],
    );
  }

  Widget _buildReviewItem(BuildContext context, ReviewItem review) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Avatar circle
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.amber.shade400, // bg-yellow-400
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  review.initial,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Tên và rating
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.studentName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Rating stars
                  Row(
                    children: List.generate(5, (index) => Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber.shade400,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Nội dung đánh giá
        Text(
          review.comment,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade700,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}



