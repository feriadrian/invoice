import 'package:intl/intl.dart';

const assets = "assets/";
const icons = "assets/icons/";
const appLogo = "${assets}app-logo.svg";

const imageSignUp = "${assets}Image-Signup.svg";
const imageSignIn = "${assets}Image-Login.svg";
const imageForgotPassword = "${assets}Image-Forgot-Password.svg";
const imageCheckbox = "${assets}checkbox.svg";
const imageSuccessSignup = "${assets}success_signup.svg";
const imageError = "assets/error.svg";

//icon yg ada di profile page
const edit = "${icons}fi-rr-pencil.svg";
const bell = "${icons}fi-rr-bell.svg";
const creditCard = "${icons}fi-rr-credit-card.svg";
const lock = "${icons}fi-rr-lock.svg";
const language = "${icons}heroicons_language.svg";
const help = "${icons}fi-rr-interrogation.svg";
const arrow = "${icons}arrow.svg";
const toggle = "${icons}Toggle.svg";

// BottomNavBar icon
const iconHome = "${icons}home_outlined.svg";
const iconHomeFilled = "${icons}home_filled.svg";
const iconInvoice = "${icons}invoice_list_outlined.svg";
const iconInvoiceFilled = "${icons}invoice_list_filled.svg";
const iconReport = "${icons}payment_report_outlined.svg";
const iconReportFilled = "${icons}payment_report_filled.svg";
const iconProfile = "${icons}profileIcon.svg";
const iconProfileFilled = "${icons}iconProfileActive.svg";
const iconNotif = "${icons}notification_outlined.svg";
const iconNotifFilled = "${icons}notification_filled.svg";
const iconChat = "${icons}chat_outlined.svg";
const iconChatFilled = "${icons}chat_filled.svg";

// REGEX FOR EMAIL VALIDATION
const emailRex =
    "^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+";

const homeSmall = "${icons}fi-sr-home.svg";
const copy = "${icons}fi-rr-copy-alt.svg";
const info = "${icons}fi-rr-info.svg";
const user = "${icons}fi-rr-user (1).svg";
const logout = "${icons}logout.svg";
const contackUs = 'assets/icons/Contact us-pana 1.svg';

// icon untuk bank
const bca = "${icons}bca.svg";
const bni = "${icons}bni.svg";
const mandiri = "${icons}mandiri.svg";

//icons yg ada pada textfield di confrim pembayaran
const calender = "${icons}fi-rr-calendar.svg";
const invoice1 = "${icons}fi-rr-invoice.svg";
const potrait = "${icons}fi-rr-portrait.svg";
const money = "${icons}fi-rr-money.svg";
const clip = "${icons}fi-rr-clip.svg";
const cross = "${icons}fi-rr-cross.svg";

const waitingConfirm = "${icons}Work time-pana 1.svg";
const suksespayment = "${icons}Successful purchase-pana (1) 1.svg";

//Notification Screen image
const emptyNotif = "${assets}empty_notification.svg";

//Notification Icon
const payment = "${icons}payment.svg";
const invoice = "${icons}invoice.svg";
const information = "${icons}info.svg";

// icon yg ada di report page
const filterIcon = "${icons}filter.svg";

NumberFormat idrFormat = NumberFormat.currency(
  locale: 'id',
  symbol: 'IDR ',
  decimalDigits: 0,
);

formatDateBasic(DateTime dateTime) {
  return DateFormat('MMM dd, yyyy').format(dateTime);
}

formatDateNotif(DateTime dateTime) {
  return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
}
