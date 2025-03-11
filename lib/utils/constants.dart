import 'package:flutter/material.dart';
import 'package:tombola/utils/extensions.dart';

const kRaffleCardRowNumber = 3;
const kRaffleCardColumnNumber = 9;
const kRaffleCardSize = 30;

const kMaxExtractableNumbers = 90;

Color kLastExtractedColor(BuildContext context) =>
    context.isDarkMode ? Colors.greenAccent : Colors.green;

final kExtractableNumbers = List.generate(
  kMaxExtractableNumbers,
  (index) => index + 1,
  growable: false,
);

// ASSETS

enum AssetMedia {
  welcomeBackground('assets/img/welcome_bg.jpg'),
  mlModenaLogo('assets/img/ml_modena_logo.png');

  const AssetMedia(this.path);
  final String path;
}

const kNumberImages = {
  1: 'https://drive.google.com/file/d/1xXGOszA71K229JpR15kP0HtgV0bpSaEE/view?usp=drive_link',
  2: 'https://drive.google.com/file/d/1OFjvwjUpGiOh2Wkh1knVmSRchafsrqKW/view?usp=drive_link',
  3: 'https://drive.google.com/file/d/1F5LYh_WhHbLO1gTb60DwfuGwPb2nt0aX/view?usp=drive_link',
  4: 'https://drive.google.com/file/d/1hCsGp0SBuxoSu127tG_FIfYgb8qv1xBP/view?usp=drive_link',
  5: 'https://drive.google.com/file/d/1xsImXmQ-w85O7Ae9fQAyST-MhK1abXup/view?usp=drive_link',
  6: 'https://drive.google.com/file/d/1jqfKuwD8ylFbGvg90LAXiaLPDCRRuQvE/view?usp=drive_link',
  7: 'https://drive.google.com/file/d/1UjXDOWOxHCY5E0oASVtvgJVxX2lbq89u/view?usp=drive_link',
  8: 'https://drive.google.com/file/d/1QwnpUiHlbjaz9H0PdQDT5OQfSHSnlFCS/view?usp=drive_link',
  9: 'https://drive.google.com/file/d/1Rfx9maSXW-B755lYdJrRXdlJq2wUAt4m/view?usp=drive_link',
  10: 'https://drive.google.com/file/d/1QG5jCvZHvldIApU4K4-w0aGAQXps9Jb3/view?usp=drive_link',
  11: 'https://drive.google.com/file/d/17TeuBOlbYCFSX1QRLO_GUErGY_y1rxb-/view?usp=drive_link',
  12: 'https://drive.google.com/file/d/1liHIu7Y9o_sj-ezTMqZzU3v_nVHbzomf/view?usp=drive_link',
  13: 'https://drive.google.com/file/d/1sWjv89T8qpD6rWbOXjKOphVgBiUY2BuL/view?usp=drive_link',
  14: 'https://drive.google.com/file/d/15o9qf-FkCbSQdVgRJ9FzOAtE4S8S8AQl/view?usp=drive_link',
  15: 'https://drive.google.com/file/d/1Ak9g4fiQSWZPsAdX8vYOyhPnVJsS9-DE/view?usp=drive_link',
  16: 'https://drive.google.com/file/d/1_YTuQcHmGZfuts242cGcQiTNXPcSIKvz/view?usp=drive_link',
  17: 'https://drive.google.com/file/d/1g7Uk32NeZMsNUgwqnNub8jLfzs6DVKsa/view?usp=drive_link',
  18: 'https://drive.google.com/file/d/1b3tJ3lINOx53hW8Us_fCZra0Hoi9KCst/view?usp=drive_link',
  19: 'https://drive.google.com/file/d/1esW4MUC7LuB8YzaAa021AtvoQF6F2xId/view?usp=drive_link',
  20: 'https://drive.google.com/file/d/1C-c0KVQUiyn_Rxr0YQra2x9ZNao2o0p3/view?usp=drive_link',
  21: 'https://drive.google.com/file/d/12J-KDXfYzrnBym_5qXq02SCQTS9ppuqW/view?usp=drive_link',
  22: 'https://drive.google.com/file/d/15cIFrCHRqptfwdUBCS6DAPz8U0Be-Jxl/view?usp=drive_link',
  23: 'https://drive.google.com/file/d/1NGhYg7oVWZ3gwcha1_gDvtzvB1EoHFTf/view?usp=drive_link',
  24: 'https://drive.google.com/file/d/1pXvna9RRkMn4Az47m-jb8rm-Obizh4Gc/view?usp=drive_link',
  25: 'https://drive.google.com/file/d/1NgDu8vOYfIaDwlmLc1_HXgc1WYjcM5rD/view?usp=drive_link',
  26: 'https://drive.google.com/file/d/1sgABJGMeEKu_q0GBqGcZsahw52G10pz1/view?usp=drive_link',
  27: 'https://drive.google.com/file/d/1CkXXguD-tUl2qM_OtHoaJF9xzTxeY5ml/view?usp=drive_link',
  28: 'https://drive.google.com/file/d/1TbL5pvbUP-NjmzUuCU0ITxcrfP9TE-Wy/view?usp=drive_link',
  29: 'https://drive.google.com/file/d/1GxP1wiwqu3DcDCiGvVHBuItqMuBO56Kt/view?usp=drive_link',
  30: 'https://drive.google.com/file/d/1kE68_a-0mDTnMW5wz4CgW5Ulk-k3uDGk/view?usp=drive_link',
  31: 'https://drive.google.com/file/d/1JmebA9CDHquOMyQKhPr348-FK9dEVNty/view?usp=drive_link',
  32: 'https://drive.google.com/file/d/1y3wbx_1Y1R0MTWRqJ31VdFHKOOC4ritI/view?usp=drive_link',
  33: 'https://drive.google.com/file/d/1W3mqEdXBLRXjwty_ka8lIuCVHHNSIoN9/view?usp=drive_link',
  34: 'https://drive.google.com/file/d/1rDJs3XZYiMRnpbLlAKItDYEaVqQDiQT0/view?usp=drive_link',
  35: 'https://drive.google.com/file/d/1fSWUINuCRH38PKoqH9cyGzS6oLu0wKsg/view?usp=drive_link',
  36: 'https://drive.google.com/file/d/1068o-nHFhh6YhbdrxtebpMUbQ2Sgnbcu/view?usp=drive_link',
  37: 'https://drive.google.com/file/d/1swPxUTkz7mAH8znJMtpVUZYfBKZCLnqp/view?usp=drive_link',
  38: 'https://drive.google.com/file/d/1E4JhfK2B3GH2AqRXa9Xo0FQEbdQ27CTT/view?usp=drive_link',
  39: 'https://drive.google.com/file/d/1cxCB5LRlCLQkhdT5DYwet6PkwNmI0X5M/view?usp=drive_link',
  40: 'https://drive.google.com/file/d/1SNWE7-_4crTHHu2XQAcTigxXYCpeMY8h/view?usp=drive_link',
  41: 'https://drive.google.com/file/d/1Zgb3ah4CsqIOzBfpv1xjujF32QKmVElB/view?usp=drive_link',
  42: 'https://drive.google.com/file/d/1y-K48ppwcaMohaNOYrpkNVLlg3DnUCdd/view?usp=drive_link',
  43: 'https://drive.google.com/file/d/196VU-wd4rTJ3xy0mBumVR2ugQI3cdy69/view?usp=drive_link',
  44: 'https://drive.google.com/file/d/1i1GFqK4ppnmzKJFfUhDYoOab_ViFz-ha/view?usp=drive_link',
  45: 'https://drive.google.com/file/d/13lmf4kLWJhoCcgoBKXIB_pLNJtpICmkA/view?usp=drive_link',
  46: 'https://drive.google.com/file/d/125U9fu1hVu48aWg5rBLp-9otACVC4Fzw/view?usp=drive_link',
  47: 'https://drive.google.com/file/d/1pnVShPOwSsiqpb9yFBJsBcC686k1xOBa/view?usp=drive_link',
  48: 'https://drive.google.com/file/d/1UiUTc-v3LaPvRMFXPf7mZKSfcrSG3AlO/view?usp=drive_link',
  49: 'https://drive.google.com/file/d/1eapytD-sDjKKYxNn4eL-8W6l5FqUoa48/view?usp=drive_link',
  50: 'https://drive.google.com/file/d/1lB9IJtIgiY-VvrOghozdXSMt_ysSq-Cx/view?usp=drive_link',
  51: 'https://drive.google.com/file/d/1hxFZEtSLM3BrlaeRqQ5oTSR5wDRwImgo/view?usp=drive_link',
  52: 'https://drive.google.com/file/d/19Dd4EQAYY58Gb4Yk2FIkE0nkZ5gfUTWW/view?usp=drive_link',
  53: 'https://drive.google.com/file/d/1wI4ABaunvRN82KvCw74HmbDdDEayeBqx/view?usp=drive_link',
  54: 'https://drive.google.com/file/d/1jdS0TwaxTRq_0GCf_p8zzm-q86z2ZlYm/view?usp=drive_link',
  55: 'https://drive.google.com/file/d/1rVmnKmbdeCwfpnLhpeV2YtSUEiYm6x0s/view?usp=drive_link',
  56: 'https://drive.google.com/file/d/15iHqQN4iBOrTlxOs3UqB4X64mG0PmprO/view?usp=drive_link',
  57: 'https://drive.google.com/file/d/1S_AtG_TvoDHdOD5cqO2YdTovkC06mk0X/view?usp=drive_link',
  58: 'https://drive.google.com/file/d/1nFK_n-BUpMwLadx18oZ-fsF5CFIjBI34/view?usp=drive_link',
  59: 'https://drive.google.com/file/d/19DIYse3eYLIqAaRxs5j8IJdXtELhllkb/view?usp=drive_link',
  60: 'https://drive.google.com/file/d/1aZySQLAWhg8WmvTJAX5CtR1cyUcqbh0g/view?usp=drive_link',
  61: 'https://drive.google.com/file/d/1D3rkIrzMJK0gw34GoznAvCZGunYp_0DV/view?usp=drive_link',
  62: 'https://drive.google.com/file/d/1h7GhbzOzb1QGm_G5BVFP0G3Hnyeg5L4g/view?usp=drive_link',
  63: 'https://drive.google.com/file/d/1zSgEP9XADlAK-3VqA9ZIvGQe_vuMGvoH/view?usp=drive_link',
  64: 'https://drive.google.com/file/d/1iwu4uJuwipj8A2ycbZbqO0xSTSAynH4g/view?usp=drive_link',
  65: 'https://drive.google.com/file/d/1WQzNWz5RQ23KSSIAPMqkuXaBAZT70YoP/view?usp=drive_link',
  66: 'https://drive.google.com/file/d/19ngIvMuMIt7oCx6olxjMTQMaWeoc2eL0/view?usp=drive_link',
  67: 'https://drive.google.com/file/d/1bvdxagCCA3L_TVNsiukCm2RWAXR1gesa/view?usp=drive_link',
  68: 'https://drive.google.com/file/d/1BCDIJ48NYOlJhEhVK4xntyqSQ4sCG831/view?usp=drive_link',
  69: 'https://drive.google.com/file/d/1e1DWd1tn7rQK1PMm1m1l525LA0ijlgNJ/view?usp=drive_link',
  70: 'https://drive.google.com/file/d/1bIpDmel09HCPJJXM95vnSRsP9hdO_dRg/view?usp=drive_link',
  71: 'https://drive.google.com/file/d/1aDjEhgX_GoE6ijFfSmqWU5v00j38dGYm/view?usp=drive_link',
  72: 'https://drive.google.com/file/d/1enrmuhTODNpmA_Rz-yH-jYapHPDrYES_/view?usp=drive_link',
  73: 'https://drive.google.com/file/d/1au6vBnQLZrVrV0JNUhwsrexumG5eKuHM/view?usp=drive_link',
  74: 'https://drive.google.com/file/d/1WprODMTgWCDq_2M2BF-v-QMkvyaOKkah/view?usp=drive_link',
  75: 'https://drive.google.com/file/d/1W4aVL9PpKeytuZJ_1Z3X2HzWLR_zotdr/view?usp=drive_link',
  76: 'https://drive.google.com/file/d/1lnnHLI5efivN7XL9SV9f2INI1PFRsADS/view?usp=drive_link',
  77: 'https://drive.google.com/file/d/1jWpGa4uKfbiKHGybM7piz40BhNyhZ1Gc/view?usp=drive_link',
  78: 'https://drive.google.com/file/d/1qQnFl4Y2BdCyNsTyOOmA15FqsbtfN4gX/view?usp=drive_link',
  79: 'https://drive.google.com/file/d/18XsU8RILauC3KD0cQzZAWAemfUMkkWCP/view?usp=drive_link',
  80: 'https://drive.google.com/file/d/1b13_XoDwifEBjjXf13xtXUi5BLjNv1Nq/view?usp=drive_link',
  81: 'https://drive.google.com/file/d/1-IHNBgws-FI7OChLcwq-oGvxccdgwvG-/view?usp=drive_link',
  82: 'https://drive.google.com/file/d/1cX2M5jLwWpOXJRwuQzMD4HQLLXivtC4d/view?usp=drive_link',
  83: 'https://drive.google.com/file/d/1RN16VTDNa2yLFxfg1vuKgOOCZjtnWsag/view?usp=drive_link',
  84: 'https://drive.google.com/file/d/1TeXvay-Vf3t09QrQDE3ji-paZXmxKmHM/view?usp=drive_link',
  85: 'https://drive.google.com/file/d/1ke6T7256ryHNOel-CJGTHwWgwwUoRr1k/view?usp=drive_link',
  86: 'https://drive.google.com/file/d/10gIJv9XD4iQVJ1hHH4t0MA2BbImFvv5q/view?usp=drive_link',
  87: 'https://drive.google.com/file/d/13Te9uKxQumZxylaD4t6jEVYnWW4IGenf/view?usp=drive_link',
  88: 'https://drive.google.com/file/d/1gFs47u_yB0TcLD93uW7HOK9JcJDkvPiY/view?usp=drive_link',
  89: 'https://drive.google.com/file/d/1Vnx1G_deFPw_iyDKF07oTxJxnokr5Tqo/view?usp=drive_link',
  90: 'https://drive.google.com/file/d/1uoE8n9PrSiHAqtHN2UvJ371vi18UbO3Q/view?usp=drive_link',
};

// SPACING

enum Spacing {
  small(8.0),
  medium(16.0),
  large(24.0);

  const Spacing(this.value);
  final double value;

  SizedBox get h => SizedBox(height: value);
  SizedBox get w => SizedBox(width: value);
}
