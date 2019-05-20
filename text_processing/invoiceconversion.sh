#!/bin/bash
# Place this script in the same directory as the data from Oracle/Finance. Ensure that all dates follow [YYYYMMDD]. Explicit_Rate is all lowercase. Exchange_Rate must have numerals only. Rename file_in to match finances data. Rename file_out as desired. Open file_out and delete first blank invoice. Check results against invoice spreadsheet.
file_in="LibraryAlmaPaymentConfirmationExtractPROD4082015-V1.csv"
file_out="LibraryAlmaPaymentConfirmationExtractPROD4082015-V1.xml"
echo '<?xml version="1.0" encoding="UTF-8"?>' > $file_out
echo '<xb:payment_confirmation_data xmlns:xb="http://com/exlibris/repository/acq/xmlbeans">' >> $file_out
echo '<xb:invoice_list>' >> $file_out
while IFS=$',' read -r -a arry
do
  echo '  <xb:invoice>' >> $file_out
  echo '    <xb:vendor_code>'${arry[0]}'</xb:vendor_code>' >> $file_out
  echo '    <xb:invoice_number>'${arry[1]}'</xb:invoice_number>' >> $file_out
  echo '    <xb:unique_identifier>'${arry[2]}'</xb:unique_identifier>' >> $file_out
  echo '    <xb:payment_status>'${arry[3]}'</xb:payment_status>' >> $file_out
  echo '    <xb:payment_note>'${arry[4]}'</xb:payment_note>' >> $file_out
  echo '    <xb:invoice_date>'${arry[5]}'</xb:invoice_date>' >> $file_out

  echo '    <xb:payment_voucher_date>'${arry[6]}'</xb:payment_voucher_date>' >> $file_out
  echo '    <xb:payment_voucher_number>'${arry[7]}'</xb:payment_voucher_number>' >> $file_out

  echo '    <xb:voucher_amount><xb:currency>'${arry[8]}'</xb:currency>' >> $file_out
  echo '    <xb:sum>'${arry[9]}'</xb:sum></xb:voucher_amount>' >> $file_out

  echo '   <xb:exchange_rates_list><xb:exchange_rate><xb:foreign_currency>'${arry[10]}'</xb:foreign_currency>' >> $file_out
  echo '    <xb:exchange_rate>'${arry[11]}'</xb:exchange_rate>' >> $file_out
  echo '    <xb:explicit_rate>'${arry[12]}'</xb:explicit_rate></xb:exchange_rate>
      </xb:exchange_rates_list>' >> $file_out
  echo '  </xb:invoice>' >> $file_out
done < $file_in
echo '</xb:invoice_list></xb:payment_confirmation_data>' >> $file_out
#escape ampersands and quoted text fields
sed -i 's/&/&amp;/' $file_out
sed -i 's/>"/>/' $file_out
sed -i 's/"</</' $file_out
