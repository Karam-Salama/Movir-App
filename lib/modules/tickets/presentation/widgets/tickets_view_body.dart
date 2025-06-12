// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:movir_app/modules/booking/data/model/booking_model.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_shimmer_widget.dart';
import '../../../booking/presentation/cubits/booking_cubit.dart';
import '../../../booking/presentation/cubits/booking_states.dart';
import '../../../booking/presentation/widgets/booking_view_app_bar.dart';

class TicketsViewBody extends StatefulWidget {
  const TicketsViewBody({super.key});

  @override
  State<TicketsViewBody> createState() => _TicketsViewBodyState();
}

class _TicketsViewBodyState extends State<TicketsViewBody> {
  @override
  void initState() {
    context.read<BookingCubit>().getUserTickets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 16, 20, 80),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(text: AppStrings.tickets),
              const SizedBox(height: 16),
              const TicketsBlocBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketsBlocBuilder extends StatelessWidget {
  const TicketsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingStates>(
      builder: (context, state) {
        if (state is TicketsLoading) {
          return ShimmerTicketsListView();
        }

        if (state is TicketsError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is TicketsSuccess) {
          final tickets = state.tickets;
          if (tickets.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Center(
                child: Text(
                  'No Tickets Found',
                  style: AppTextStyle.Kanit400style16White.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return TicketCard(booking: ticket);
            },
          );
        }

        return const Center(child: Text('Unexpected state'));
      },
    );
  }
}

class ShimmerTicketsListView extends StatelessWidget {
  const ShimmerTicketsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmerWidget(
                  height: 120,
                  width: 100,
                  borderRadius: 8,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomShimmerWidget(
                        height: 20,
                        width: double.infinity,
                        borderRadius: 4,
                      ),
                      const SizedBox(height: 8),
                      CustomShimmerWidget(
                        height: 16,
                        width: 150,
                        borderRadius: 4,
                      ),
                      const SizedBox(height: 4),
                      CustomShimmerWidget(
                        height: 16,
                        width: 120,
                        borderRadius: 4,
                      ),
                      const SizedBox(height: 4),
                      CustomShimmerWidget(
                        height: 16,
                        width: 100,
                        borderRadius: 4,
                      ),
                      const SizedBox(height: 4),
                      CustomShimmerWidget(
                        height: 16,
                        width: 80,
                        borderRadius: 4,
                      ),
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
}

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.booking});
  final Booking booking;

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Booking'),
        content: const Text('Are you sure you want to delete this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<BookingCubit>().deleteBooking(booking.id!);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: Colors.white.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(booking.moviePoster),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        booking.movieName,
                        style: AppTextStyle.Kanit400style16White,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SvgPicture.asset(Assets.assetsSvgsLocationIcon),
                          const SizedBox(width: 4),
                          Text(
                            booking.cinemaName,
                            style: AppTextStyle.Kanit400style12Grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(Assets.assetsSvgscalendarIcon),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('dd/MM/yyyy').format(booking.date),
                            style: AppTextStyle.Kanit400style12Grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(Assets.assetsSvgsTimeIcon),
                          const SizedBox(width: 4),
                          Text(
                            booking.time,
                            style: AppTextStyle.Kanit400style12Grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          for (var seat in booking.seats)
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child:
                                  SvgPicture.asset(Assets.assetsSvgsSeatIcon),
                            ),
                          const SizedBox(width: 4),
                          Text(
                            '${booking.seats.length} Seats',
                            style: AppTextStyle.Kanit400style12Grey,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () => _showDeleteConfirmationDialog(context),
            icon: const Icon(
              Icons.delete,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
