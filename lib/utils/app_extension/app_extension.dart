import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseAuthErrorHandler on FirebaseAuthException {
  String get friendlyMessage {
    switch (code) {
      case 'invalid-email':
        return "Elektron pochta manzili noto'g'ri!";
      case 'user-disabled':
        return "Bu foydalanuvchi bloklangan!";
      case 'user-not-found':
        return "Foydalanuvchi topilmadi!";
      case 'wrong-password':
        return "Noto'g'ri parol kiritildi!";
      case 'email-already-in-use':
        return "Bu elektron pochta allaqachon ro'yxatdan o'tgan!";
      case 'operation-not-allowed':
        return "Ushbu amalga ruxsat berilmagan!";
      case 'weak-password':
        return "Parol juda zaif! Iltimos, kuchliroq parol tanlang.";
      case 'too-many-requests':
        return "Juda ko'p so'rov yuborildi. Keyinroq urinib ko'ring!";
      case 'network-request-failed':
        return "Internetga ulanishda xatolik yuz berdi!";
      default:
        return "Noma'lum xatolik: $message";
    }
  }
}

extension FirebaseErrorHandler on FirebaseException {
  String get friendlyMessage {
    switch (code) {
      case 'permission-denied':
        return "Ruxsat berilmagan!";
      case 'unavailable':
        return "Xizmat vaqtincha mavjud emas!";
      case 'not-found':
        return "Ma'lumot topilmadi!";
      case 'already-exists':
        return "Ma'lumot allaqachon mavjud!";
      case 'cancelled':
        return "Amal bekor qilindi!";
      case 'deadline-exceeded':
        return "So'rov uchun vaqt tugadi!";
      case 'invalid-argument':
        return "Noto'g'ri argument kiritildi!";
      case 'unauthenticated':
        return "Foydalanuvchi avtorizatsiyadan o'tmagan!";
      case 'failed-precondition':
        return "Shart bajarilmagan!";
      case 'aborted':
        return "Amal to'xtatildi!";
      case 'out-of-range':
        return "Qiymat diapazondan tashqarida!";
      default:
        return "Noma'lum xatolik: $message";
    }
  }
}
