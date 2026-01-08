import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:santhosh_bakery/core/app_theme.dart';
import 'package:santhosh_bakery/providers/cart_provider.dart';
import 'package:santhosh_bakery/data/models/order.dart';
import 'package:santhosh_bakery/providers/orders_provider.dart';
import 'package:santhosh_bakery/providers/auth_provider.dart';
import 'package:santhosh_bakery/screens/order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String _orderType = 'Home Delivery';
  String _paymentMethod = 'UPI'; // Default to Online for safety

  // Controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  void _setOrderType(String type) {
    setState(() {
      _orderType = type;
      // Rule: If Home Delivery is selected, COD is NOT allowed.
      if (_orderType == 'Home Delivery' &&
          _paymentMethod == 'Cash on Delivery') {
        _paymentMethod = 'UPI'; // Auto-switch to valid option
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Cash on Delivery is not available for Home Delivery. Switched to Online Payment.',
            ),
            backgroundColor: AppTheme.primaryOrange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  bool get _isCodAvailable => _orderType == 'Pickup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Information',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Order Type',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildRadioOption(
                      'Home Delivery',
                      Icons.delivery_dining,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: _buildRadioOption('Pickup', Icons.store)),
                ],
              ),

              if (_orderType == 'Home Delivery') ...[
                const SizedBox(height: 24),
                Text(
                  'Delivery Address',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.blue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Online payment is required for Home Delivery.',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Full Address',
                    prefixIcon: Icon(Icons.location_on_outlined),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
              ],

              const SizedBox(height: 24),
              Text(
                'Payment Method',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    // UPI Option
                    ListTile(
                      leading: const Icon(
                        Icons.qr_code,
                        color: AppTheme.primaryDark,
                      ),
                      title: const Text('UPI (Google Pay / PhonePe)'),
                      subtitle: const Text('Fast & Secure'),
                      trailing: Radio<String>(
                        value: 'UPI',
                        groupValue: _paymentMethod,
                        activeColor: AppTheme.primaryDark,
                        onChanged: (value) {
                          setState(() {
                            _paymentMethod = value!;
                          });
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    // COD Option
                    Opacity(
                      opacity: _isCodAvailable ? 1.0 : 0.5,
                      child: ListTile(
                        leading: const Icon(Icons.money, color: Colors.green),
                        title: const Text('Cash on Delivery'),
                        subtitle: !_isCodAvailable
                            ? const Text(
                                'Only available for Store Pickup',
                                style: TextStyle(color: Colors.red),
                              )
                            : null,
                        trailing: Radio<String>(
                          value: 'Cash on Delivery',
                          groupValue: _paymentMethod,
                          activeColor: AppTheme.primaryDark,
                          onChanged: _isCodAvailable
                              ? (value) {
                                  setState(() {
                                    _paymentMethod = value!;
                                  });
                                }
                              : null, // Disable selection
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        (_orderType == 'Home Delivery' &&
                            _paymentMethod == 'Cash on Delivery')
                        ? Colors.grey
                        : AppTheme.primaryDark,
                  ),
                  onPressed: () {
                    // Critical Business Logic Check: Payment
                    if (_orderType == 'Home Delivery' &&
                        _paymentMethod == 'Cash on Delivery') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Online payment is required for home delivery orders.',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Critical Business Logic Check: Guest & Home Delivery
                    final auth = Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    );
                    if (auth.isGuest && _orderType == 'Home Delivery') {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Login Required'),
                          content: const Text(
                            'Please login to place Home Delivery orders. Guests can only choose Store Pickup.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      // Create Order Object
                      final cart = Provider.of<CartProvider>(
                        context,
                        listen: false,
                      );
                      final newOrder = Order(
                        id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
                        dateTime: DateTime.now(),
                        items: cart.items,
                        totalAmount: cart
                            .totalAmount, // You might want to add delivery charge logic here if needed
                        status: 'Placed',
                        deliveryType: _orderType,
                        paymentMethod: _paymentMethod,
                        address: _orderType == 'Home Delivery'
                            ? _addressController.text
                            : 'Pickup from Store',
                        deliveryCharge: _orderType == 'Home Delivery'
                            ? 40.0
                            : 0.0, // Example fixed charge
                      );

                      // Save Order
                      Provider.of<OrdersProvider>(
                        context,
                        listen: false,
                      ).addOrder(newOrder);

                      // Clear cart
                      cart.clearCart();

                      // Navigate to success
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderSuccessScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text('Place Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String value, IconData icon) {
    final isSelected = _orderType == value;
    return GestureDetector(
      onTap: () => _setOrderType(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.primaryDark : Colors.grey.shade200,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryDark.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppTheme.lightText,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: isSelected ? Colors.white : AppTheme.darkText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
