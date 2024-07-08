/*
 * //////////////////////////////////////////////////////////
 * // C O P Y R I G H T (c) 2023                           //
 * // DBDOYC Inc. and/or its affiliates.                   //
 * // All Rights Reserved                                  //
 * //////////////////////////////////////////////////////////
 * //                                                      //
 * // THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE of       //
 * // DBDOYC Inc. and/or its affiliates.                   //
 * // The copyright notice above does not evidency any     //
 * // actual or intended publication of such source code.  //
 * //                                                      //
 * //////////////////////////////////////////////////////////
 */

import 'package:injectable/injectable.dart';

abstract class DelayProvider {
  Future<void> delay(int milliseconds);
}

@LazySingleton(as: DelayProvider)
class DelayProviderImpl implements DelayProvider {
  @override
  Future<void> delay(int milliseconds) => Future.delayed(Duration(milliseconds: milliseconds));
}
