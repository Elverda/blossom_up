import 'package:flutter/material.dart';

class ChatAdminScreen extends StatefulWidget {
  const ChatAdminScreen({Key? key}) : super(key: key);

  @override
  State<ChatAdminScreen> createState() => _ChatAdminScreenState();
}

class _ChatAdminScreenState extends State<ChatAdminScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    // Pesan sambutan dari bot
    _addBotMessage('Halo! Ada yang bisa saya bantu? Anda bisa bertanya tentang pengiriman, diskon, atau produk.');
  }

  void _addMessage(String text, {bool isUser = false}) {
    setState(() {
      _messages.insert(0, {'text': text, 'isUser': isUser});
    });
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _addBotMessage(String text) {
    _addMessage(text, isUser: false);
  }

  void _handleSendPressed() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      _addMessage(text, isUser: true);
      _controller.clear();
      // Bot merespons setelah jeda singkat
      Future.delayed(const Duration(milliseconds: 800), () {
        _getBotResponse(text);
      });
    }
  }

  void _getBotResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    String response;

    if (message.contains('pengiriman') || message.contains('kirim')) {
      response = 'Kami mendukung pengiriman ke seluruh Indonesia. Estimasi waktu pengiriman adalah 2-5 hari kerja.';
    } else if (message.contains('diskon') || message.contains('voucher') || message.contains('promo')) {
      response = 'Semua voucher yang tersedia dapat Anda lihat di halaman keranjang belanja. Coba gunakan kode HEMAT10 untuk diskon 10%!';
    } else if (message.contains('produk') || message.contains('bunga') || message.contains('tersedia')) {
      response = 'Semua produk yang Anda lihat di halaman shop adalah produk yang tersedia dan siap untuk dipesan.';
    } else if (message.contains('terima kasih') || message.contains('makasih')) {
      response = 'Sama-sama! Senang bisa membantu.';
    } else if (message.contains('halo') || message.contains('hai')) {
      response = 'Halo kembali! Ada yang bisa dibantu?';
    } else {
      response = 'Maaf, saya belum mengerti pertanyaan Anda. Coba tanyakan tentang: pengiriman, diskon, atau produk.';
    }

    _addBotMessage(response);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat dengan Admin'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message['text'], message['isUser'], theme);
              },
            ),
          ),
          _buildMessageComposer(theme),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser, ThemeData theme) {
    final alignment = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = isUser ? theme.primaryColor : theme.cardColor;
    final textColor = isUser ? Colors.white : theme.textTheme.bodyLarge?.color;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Ketik pesan...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                onSubmitted: (_) => _handleSendPressed(),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: theme.primaryColor),
              onPressed: _handleSendPressed,
            ),
          ],
        ),
      ),
    );
  }
}
