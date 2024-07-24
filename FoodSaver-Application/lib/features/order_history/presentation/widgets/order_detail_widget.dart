import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/parse_utils.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/entities/order_entity.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class OrderDetailWidget extends StatefulWidget {
  const OrderDetailWidget({super.key, required this.orderEntity});
  final OrderEntity orderEntity;

  @override
  State<OrderDetailWidget> createState() => _OrderDetailWidgetState();
}

class _OrderDetailWidgetState extends State<OrderDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(9, 30, 66, 0.25),
            blurRadius: 8,
            spreadRadius: -2,
            offset: Offset(
              0,
              4,
            ),
          ),
          BoxShadow(
            color: Color.fromRGBO(9, 30, 66, 0.08),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mã: ${widget.orderEntity.orderCode!}',
            style: AppTextStyle.primaryText().copyWith(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: Colors.orangeAccent,
                      size: 15.w,
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Text(
                        widget.orderEntity.creatorName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.smallText().copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5.w),
              Text(
                ParseUtils.formatDateTime(
                  widget.orderEntity.publishedDate.toString(),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.smallText().copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text(
                'Trạng thái: ',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.smallText().copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                ParseUtils.convertStatusTypeText(widget.orderEntity.statusType),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.smallText().copyWith(
                  color: ParseUtils.convertStatusTypeColor(
                    widget.orderEntity.statusType,
                  ),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  ParseUtils.convertPaymentTypeText(widget.orderEntity.paymentType),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.smallText().copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  ParseUtils.convertShippingTypeText(widget.orderEntity.shippingType),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.smallText().copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            height: 1.h,
            color: const Color(0xFFCACACA).withOpacity(0.5),
          ),
          SizedBox(height: 10.h),
          Column(
            children: widget.orderEntity.orderDetails
                .map(
                  (e) => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.r),
                            child: ImageParse(
                              width: 45.w,
                              height: 45.w,
                              url: e!.productImage.toString(),
                              type: 'order/${e.id}',
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            flex: 3,
                            child: Text(e.productName!, style: AppTextStyle.smallText()),
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            child: Text('x${e.unitQuantity}', style: AppTextStyle.smallText()),
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            flex: 2,
                            child: Text(
                              ParseUtils.formatCurrencyWithoutSymbol(e.unitPrice.toDouble()),
                              style: AppTextStyle.smallText(),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            flex: 2,
                            child: Text(
                              ParseUtils.formatCurrencyWithoutSymbol(
                                (e.unitPrice * e.unitQuantity).toDouble(),
                              ),
                              style: AppTextStyle.smallText(),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: const Color(0xFFCACACA).withOpacity(0.5),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 5.w),
              Text(
                ParseUtils.formatCurrency(
                  widget.orderEntity.totalAmount.toDouble(),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.smallText().copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
