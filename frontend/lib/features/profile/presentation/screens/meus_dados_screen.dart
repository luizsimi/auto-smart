import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_navigation.dart';
import '../../../../core/theme/colors.dart';
import '../../../services/presentation/screens/home_screen.dart';
import '../../../search/presentation/screens/search_screen.dart';
import '../../../earnings/presentation/screens/ganhos_screen.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import 'edit_profile_screen.dart';

class MeusDadosScreen extends StatefulWidget {
  const MeusDadosScreen({super.key});

  @override
  State<MeusDadosScreen> createState() => _MeusDadosScreenState();
}

class _MeusDadosScreenState extends State<MeusDadosScreen> {
  int _selectedBottomIndex = 3; // Perfil selecionado (ícone de pessoa)

  // Função para abrir WhatsApp com suporte
  Future<void> _openWhatsAppSupport() async {
    // Verificar horário de atendimento antes de abrir
    if (!_isWithinBusinessHours()) {
      _showBusinessHoursDialog();
      return;
    }

    // Se estiver dentro do horário, abre o WhatsApp normalmente
    _openWhatsAppDirectly();
  }

  // Verificar se está dentro do horário de atendimento (8:30 às 17:30)
  bool _isWithinBusinessHours() {
    final now = DateTime.now();

    // Verificar se é fim de semana (sábado = 6, domingo = 7)
    if (now.weekday == DateTime.saturday || now.weekday == DateTime.sunday) {
      return false;
    }

    // Horário de atendimento: 8:30 às 17:30
    final startTime = DateTime(now.year, now.month, now.day, 8, 30);
    final endTime = DateTime(now.year, now.month, now.day, 17, 30);

    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  // Mostrar diálogo informando sobre o horário de atendimento
  void _showBusinessHoursDialog() {
    final now = DateTime.now();
    final isWeekend =
        now.weekday == DateTime.saturday || now.weekday == DateTime.sunday;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.schedule, color: AppColors.primary, size: 28),
            const SizedBox(width: 12),
            const Text('Fora do Horário', style: TextStyle(fontSize: 20)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isWeekend)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.weekend, color: Colors.orange[700]),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Não atendemos aos finais de semana',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[700]),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Estamos fora do horário de atendimento no momento',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            const Text(
              '⏰ Horário de Atendimento:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.calendar_today, 'Segunda a Sexta'),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.access_time, '8:30 às 17:30'),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.phone, color: Colors.green[700], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Você pode enviar sua mensagem mesmo fora do horário. Responderemos assim que possível!',
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              _openWhatsAppDirectly();
            },
            icon: const Icon(Icons.send, size: 18),
            label: const Text('Enviar Mesmo Assim'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25D366),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para exibir linhas de informação
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      ],
    );
  }

  // Abrir WhatsApp diretamente (usada internamente)
  Future<void> _openWhatsAppDirectly() async {
    // CONFIGURAÇÃO: Altere estes valores conforme necessário
    const phoneNumber =
        '5519971388231'; // Formato: Código do país + DDD + número (sem espaços ou caracteres especiais)
    const message = 'Olá! Preciso de ajuda com o app AUTOSMART.';

    // Criar URL do WhatsApp
    final whatsappUrl = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );

    try {
      // Tentar abrir WhatsApp
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        // Caso WhatsApp não esteja instalado
        if (!mounted) return;
        _showErrorDialog(
          'WhatsApp não encontrado',
          'Por favor, instale o WhatsApp para usar este recurso ou entre em contato pelo telefone: ${_formatPhoneNumber(phoneNumber)}',
        );
      }
    } catch (e) {
      // Erro ao abrir WhatsApp
      if (!mounted) return;
      _showErrorDialog(
        'Erro ao abrir WhatsApp',
        'Não foi possível abrir o WhatsApp. Tente novamente mais tarde.',
      );
    }
  }

  // Formatar número de telefone para exibição
  String _formatPhoneNumber(String phone) {
    if (phone.length >= 13) {
      final country = phone.substring(0, 2);
      final ddd = phone.substring(2, 4);
      final firstPart = phone.substring(4, 9);
      final secondPart = phone.substring(9);
      return '+$country ($ddd) $firstPart-$secondPart';
    }
    return phone;
  }

  // Mostrar diálogo de erro
  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: const CustomAppBar(title: 'MEUS DADOS', showBackButton: false),
      body: Column(
        children: [
          // Header padronizado
          Container(
            width: double.infinity,
            height: 50,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Text(
                'PERFIL',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Seção Ações Rápidas
                  const Text(
                    'Ações Rápidas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Botão Editar dados Pessoais
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.08),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Editar dados Pessoais',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Clique para editar seus dados pessoais',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Botão Logout
                  GestureDetector(
                    onTap: () {
                      // Logout mockado - navega para a tela de login
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.08),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Sair da sua conta',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _selectedBottomIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomIndex = index;
          });

          // Navegação para Home quando clicar no ícone home
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }

          // Navegação para a tela de pesquisa quando clicar no ícone de lupa
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          }

          // Navegar para Meus Ganhos ao clicar no ícone de $ (index 2)
          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const GanhosScreen()),
            );
          }

          // Navegação direta - Meus Dados (index 3) já está na tela atual
        },
      ),
      // Botão flutuante de suporte via WhatsApp
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Tooltip(
          message: 'Fale com o suporte',
          child: FloatingActionButton(
            onPressed: _openWhatsAppSupport,
            backgroundColor: const Color(
              0xFF25D366,
            ), // Verde oficial do WhatsApp
            elevation: 6,
            child: const Icon(
              Icons.support_agent,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
