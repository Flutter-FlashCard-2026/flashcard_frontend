import 'package:flash_card/models/voca.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // 날짜 포맷팅용

class VocaCard extends StatelessWidget {
  final Voca voca;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const VocaCard({
    super.key,
    required this.voca,
    this.onDelete,
    this.onEdit
  });

  @override
  Widget build(BuildContext context) {
    // 날짜 로직: 수정일(updatedAt)이 있으면 쓰고, 없으면 생성일(createdAt) 사용
    final displayDate = voca.updatedAt ?? voca.createdAt;
    
    // 날짜 포맷
    final dateString = DateFormat('yyyy.MM.dd').format(displayDate);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        // 클릭 시 단어장 상세 화면으로 이동
        // arguments로 현재 voca 데이터를 넘겨줌
        onTap: () {
          Get.toNamed('/word', arguments: voca);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0), // 내부 여백 넉넉하게
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목 (길어지면 ... 처리)
                  Expanded(
                    child: Text(
                      voca.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  
                  // 더보기 버튼 (수정/삭제)
                  if (onDelete != null || onEdit != null)
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: PopupMenuButton<String>(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.more_vert, size: 20, color: Colors.grey),
                        color: Colors.white, // 팝업 메뉴 배경도 흰색으로
                        itemBuilder: (context) => [
                          // 수정 버튼
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 18, color: Colors.black54),
                                SizedBox(width: 8),
                                Text('수정'),
                              ],
                            ),
                          ),
                          // 삭제 버튼
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 18, color: Colors.red),
                                SizedBox(width: 8),
                                Text('삭제', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 'edit') {
                            if (onEdit != null) onEdit!(); // 수정 실행
                          }
                          if (value == 'delete') {
                            if (onDelete != null) onDelete!(); // 삭제 실행
                          }
                        },
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              
              // 날짜 표시
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    dateString, 
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}