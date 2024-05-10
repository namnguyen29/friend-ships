@isTest
public class TestRestrictContactByName {
  @isTest
  static void testRestrictTrigger() {
    // Tạo danh sách contact để test
    List<Contact> ctcList = new List<Contact>();

    // Tạo contact hợp lệ
    Contact validContact = new Contact(LastName = 'ValidName');
    ctcList.add(validContact);

    // Tạo contact không hợp lệ
    Contact invalidContact = new Contact(LastName = 'INVALIDNAME');
    ctcList.add(invalidContact);

    // Chạy trigger
    Test.startTest();
    Database.SaveResult[] results = Database.insert(ctcList, false);
    Test.stopTest();

    // Kiểm tra kết quả
    System.assertEquals(1, results.size()); // Kiểm tra số lượng kết quả

    // Lấy kết quả của contact không hợp lệ
    Database.SaveResult invalidResult = results[0];
    System.assert(invalidResult.isSuccess()); // Kiểm tra kết quả không thành công

    // Kiểm tra lỗi
    List<Database.Error> errors = invalidResult.getErrors();
    System.assertEquals(1, errors.size()); // Kiểm tra số lượng lỗi
    System.assertEquals(
      'The Last Name "INVALIDNAME" is not allowed for DML',
      errors[0].getMessage()
    ); // Kiểm tra thông báo lỗi

    // Kiểm tra trường hợp contact hợp lệ
    System.assertEquals(false, validContact.hasErrors()); // Kiểm tra contact hợp lệ không có lỗi
  }
}