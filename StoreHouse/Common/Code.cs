using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace StoreHouse.Models.Constants
{
    public enum Code
    {
        /// <summary>
        ///     The request handled successfully
        /// </summary>
        [Description("")]
        Success = 0,

        /// <summary>
        ///     The access token is required
        /// </summary>
        [Description("Token required")]
        TokenRequired = 1,

        /// <summary>
        ///     Incorrect token
        /// </summary>
        [Description("Incorrect token")]
        TokenIncorrect = 2,

        /// <summary>
        /// Authentication required
        /// </summary>
        [Description("Authentication required")]
        AuthRequired = 3,

        /// <summary>
        /// Permission denied
        /// </summary>
        [Description("Permission denied")]
        PermissionDenied = 4,

        /// <summary>
        /// Name is required
        /// </summary>
        [Description("Name is required")]
        NameRequired = 5,

        /// <summary>
        /// ID is required
        /// </summary>
        [Description("ID is required")]
        IDRequired = 6,

        /// <summary>
        /// Identifier is required
        /// </summary>
        [Description("Identifier is required")]
        IdentRequired = 7,
        /// <summary>
        /// Identifier is required
        /// </summary>
        [Description("Невозможно выполнить оперцию, проверьте правильность введенных данных")]
        OperationFailed = 8,

        #region Client Errors 4xx

        /// <summary>
        ///     The bad request
        /// </summary>
        [Description("Bad Request")]
        BadRequest = 400,

        /// <summary>
        ///     The unauthorized access
        /// </summary>
        [Description("Unauthorized")]
        Unauthorized = 401,

        /// <summary>
        ///     The access to recourse forbidden
        /// </summary>
        [Description("Forbidden")]
        Forbidden = 403,

        /// <summary>
        ///     Required recourse not found within system
        /// </summary>
        [Description("Not found")]
        NotFound = 404,

        /// <summary>
        ///     The request entity's media type is not supported for this resource.
        /// </summary>
        [Description("The request entity's media type is not supported for this resource")]
        UnsupportedMediaType = 415,

        #endregion

        #region Server Errors 5xx

        /// <summary>
        ///     Method not implemented
        /// </summary>
        [Description("Not implemented")]
        NotImplemented = 501,

        /// <summary>
        ///     Unexpected error
        /// </summary>
        [Description("Unexpected error occurred, please try again or contact the administrator")]
        UnexpectedError = 500,

        #endregion

        #region Application Validation Codes 6xxx

        /// <summary>
        /// The index must be not null and more then zero
        /// </summary>
        [Description("The order # must be not null and more then zero")]
        OrderRequired = 600,

        #endregion

        #region User Validation Codes 7xxx

        /// <summary>
        ///     The login field is required
        /// </summary>
        [Description("The login field is required")]
        LoginRequired = 700,

        /// <summary>
        ///     The Email field is required
        /// </summary>
        [Description("The Email field is required")]
        EmailRequired = 701,

        /// <summary>
        ///     The address field is required
        /// </summary>
        [Description("The address field is required")]
        AddressRequired = 702,

        /// <summary>
        ///     The avatar image, base64 string is required.
        /// </summary>
        [Description("The avatar image, base64 string is required.")]
        AvatarRequired = 703,

        /// <summary>
        ///     The avatar image content/type is required.
        /// </summary>
        [Description("The avatar image content/type is required.")]
        AvatarTypeRequired = 704,

        /// <summary>
        ///     The Email field is  invalid
        /// </summary>
        [Description("The email field is  invalid")]
        EmailInvalid = 705,

        /// <summary>
        ///     The avatar image, error save on disk.
        /// </summary>
        [Description("The avatar image, error save on disk")]
        AvatarSaveError = 706,

        /// <summary>
        ///     Address field exceeds the maximum length
        /// </summary>
        [Description("The address field exceeds the maximum length")]
        BadAddressFieldLenght = 707,

        /// <summary>
        ///     Login field exceeds the maximum length
        /// </summary>
        [Description("The login field exceeds the maximum length")]
        BadLoginFieldLenght = 708,

        /// <summary>
        ///     Email field exceeds the maximum length
        /// </summary>
        [Description("The email field exceeds the maximum length")]
        BadEmailFieldLenght = 709,

        /// <summary>
        ///     Password field exceeds the maximum length
        /// </summary>
        [Description("The password field exceeds the maximum length")]
        BadPassFieldLenght = 710,

        /// <summary>
        ///     TI field exceeds the maximum length
        /// </summary>
        [Description("The TI field exceeds the maximum length")]
        BadTiFieldLenght = 711,

        /// <summary>
        ///     FI field exceeds the maximum length
        /// </summary>
        [Description("The FI field exceeds the maximum length")]
        BadFiFieldLenght = 712,

        /// <summary>
        ///     GI field exceeds the maximum length
        /// </summary>
        [Description("The GI field exceeds the maximum length")]
        BadGiFieldLenght = 713,

        /// <summary>
        ///     The password field is required
        /// </summary>
        [Description("The password field is required")]
        PasswordRequired = 714,

        /// <summary>
        ///     The old password field is required
        /// </summary>
        [Description("The old password field is required")]
        OldPasswordRequired = 736,

        /// <summary>
        ///     Duplicate login field
        /// </summary>
        [Description("Duplicate login field")]
        DuplicateLogin = 715,

        /// <summary>
        ///     The loc_visibility field is out of range
        /// </summary>
        [Description("The loc_visibility field is out of range")]
        LocVisibilityOutOfRange = 716,

        /// <summary>
        ///     The device type field is out of range
        /// </summary>
        [Description("The device type field is out of range")]
        DeviceTypeOutOfRange = 717,

        /// <summary>
        ///     The user id field is required
        /// </summary>
        [Description("The user id field is required")]
        UserIdRequired = 718,
        /// <summary>
        /// The user settings field is required
        /// </summary>
        [Description("The user settings field is required")]
        SettingsRequired = 719,
        /// <summary>
        /// The user id value is incorrect
        /// </summary>
        [Description("The user with id value is not found")]
        UserIdIncorrect = 720,
        /// <summary>
        ///  Duplicate Twitter identificator field
        /// </summary>
        [Description("Duplicate Twitter identificator field")]
        DuplicateTi = 721,
        /// <summary>
        ///  Duplicate Facebook identificator field
        /// </summary>
        [Description("Duplicate Facebook identificator field")]
        DuplicateFi = 722,
        /// <summary>
        ///  Duplicate Google identificator field
        /// </summary>
        [Description("Duplicate Google identificator field")]
        DuplicateGi = 723,
        /// <summary>
        ///     The Username field is required
        /// </summary>
        [Description("The Username field is required")]
        UsernameRequired = 724,
        /// <summary>
        /// The username field exceeds the maximum length
        /// </summary>
        [Description("The username field exceeds the maximum length")]
        UsernameFieldLenght = 725,
        /// <summary>
        /// There are many social network identifiers
        /// </summary>
        [Description("There are many social network identifiers")]
        ManySocialIdentificators = 726,
        /// <summary>
        /// The FI identifier can not be an empty string
        /// </summary>
        [Description("The FI identifier can not be an empty string")]
        FiEmptyStringIdentifier = 727,
        /// <summary>
        /// The GI identifier can not be an empty string
        /// </summary>
        [Description("The GI identifier can not be an empty string")]
        GiEmptyStringIdentifier = 728,
        /// <summary>
        /// The TI identifier can not be an empty string
        /// </summary>
        [Description("The TI identifier can not be an empty string")]
        TiEmptyStringIdentifier = 729,
        /// <summary>
        /// The user has been deleted
        /// </summary>
        [Description("The user has been deleted")]
        UserHasDeleted = 730,
        /// <summary>
        /// The user blocked
        /// </summary>
        [Description("The user is blocked")]
        UserHasBlocked = 731,
        /// <summary>
        ///  Duplicate Facebook identificator field
        /// </summary>
        [Description("Duplicate social network identifier field")]
        DuplicateSocialId = 732,
        [Description("The isDeleted field is required")]
        DeletedFieldReq = 733,
        [Description("The isLocked field is required")]
        LockedFieldReq = 734,
        /// <summary>
        /// Login failed, email or password are incorrect, try again later
        /// </summary>
        [Description("Ошибка авторизации, неправильный логин или пароль")]
        LoginFailed = 735,
        /// <summary>
        /// User not found, please check entered Email address
        /// </summary>
        [Description("User not found, please check entered Email address")]
        UserWithEmailNotFound = 737,
        /// <summary>
        /// Failed to send email, please contact with your system administrator.
        /// </summary>
        [Description("Failed to send email, please contact with your system administrator.")]
        EmailSendFailed = 738,
        /// <summary>
        /// User with this email already exists.
        /// </summary>
        [Description("User with this email already exists.")]
        EmailExists = 739,
        /// <summary>
        /// Import process has errors.
        /// </summary>
        [Description("Import process has errors.")]
        ImportPrecessError = 740,
        /// <summary>
        /// User with this username already exists.
        /// </summary>
        [Description("User with this username already exists.")]
        UserNameExists = 741,
        #endregion

        #region Request validation error codes 8xx

        /// <summary>
        ///     The login field is required
        /// </summary>
        [Description("The request id field is required")]
        RiRequired = 800,

        /// <summary>
        ///     The Number of competes field required
        /// </summary>
        [Description("The Number of competes field required")]
        CompetesRequired = 801,

        /// <summary>
        ///     The end of time field required
        /// </summary>
        [Description("The end of time field required")]
        EndRequired = 802,

        /// <summary>
        ///     The karma points field required
        /// </summary>
        [Description("The karma points field required")]
        KarmapointsRequired = 803,

        /// <summary>
        ///     The location field required
        /// </summary>
        [Description("The location field required")]
        LocationRequired = 804,

        /// <summary>
        ///     The message field required
        /// </summary>
        [Description("The message field required")]
        MessageRequired = 805,

        /// <summary>
        ///     The actual start time field required
        /// </summary>
        [Description("The actual start time field required")]
        StartRequired = 806,

        /// <summary>
        ///     The request type field required
        /// </summary>
        [Description("The request type field required")]
        ReqTypeRequired = 807,

        /// <summary>
        ///     The request SI field required
        /// </summary>
        [Description("The request SI field is required")]
        SIRequired = 808,

        /// <summary>
        ///     The request info is required
        /// </summary>
        [Description("The request type field required")]
        RequestRequired = 809,

        /// <summary>
        ///     The request SI field required
        /// </summary>
        [Description("The user location field required")]
        UserLocationRequired = 810,

        /// <summary>
        /// The Radius location field required
        /// </summary>
        [Description("The Radius location field required")]
        LocationRadiusRequired = 811,

        /// <summary>
        /// The latitude location field required
        /// </summary>
        [Description("The latitude location field required")]
        LatitudeRequired = 812,

        /// <summary>
        /// The longitude location field required
        /// </summary>
        [Description("The longitude location field required")]
        LongitudeRequired = 813,

        /// <summary>
        /// The request id value is incorrect
        /// </summary>
        [Description("The available request is not found")]
        RequestIdIncorrect = 814,

        /// <summary>
        /// The request id is required
        /// </summary>
        [Description("The request id is required")]
        RequestIdRequired = 815,
        /// <summary>
        /// The latitude location field is out of range
        /// </summary>
        [Description("The latitude location field is out of range")]
        LatitudeOutOfRange = 816,

        /// <summary>
        /// The longitude location field is out of range
        /// </summary>
        [Description("The longitude location field is out of range")]
        LongitudeOutOfRange = 817,

        /// <summary>
        /// The longitude location field is out of range
        /// </summary>
        [Description("The request type is required field")]
        TypeRequired = 818,

        /// <summary>
        /// The media content is empty
        /// </summary>
        [Description("The media content is required field")]
        MediaContentRequired = 819,

        /// <summary>
        /// The longitude location field is out of range
        /// </summary>
        [Description("Error loading of media file")]
        MediaContentLoadError = 820,

        /// <summary>
        /// The media content is empty
        /// </summary>
        [Description("The media content type is required field")]
        MediaContentTypeRequired = 821,

        /// <summary>
        /// The response id value is incorrect
        /// </summary>
        [Description("The available response is not found")]
        ResponseIdIncorrect = 822,

        /// <summary>
        /// Creator can not accept to own request
        /// </summary>
        [Description("Creator can not accept to own request")]
        OwnRequestNotAccepted = 823,
        /// <summary>
        /// Elapsed time of the request
        /// </summary>
        [Description("Elapsed time of the request")]
        OwnRequestElapsedTime = 824,
        /// <summary>
        /// Elapsed time of the request
        /// </summary>
        [Description("Accepter have the small rating")]
        OwnSmallRating = 825,
        /// <summary>
        ///     The timestamp field is required
        /// </summary>
        [Description("The timestamp field is required")]
        TimeStampRequired = 826,
        /// <summary>
        /// Incorrect value the old password
        /// </summary>
        [Description("Incorrect value the old password")]
        OldPassIncorrect = 827,
        /// <summary>
        /// Not enough karma points
        /// </summary>
        [Description("You don't have enough KP. Help out others to get Karma to create new requests")]
        NotEnouoghKarmaPoint = 828,
        /// <summary>
        ///  The time zone is required
        /// </summary>
        [Description("The time zone is required")]
        TimeZoneRequired = 829,
        /// <summary>
        ///  Один или несколько инструментов еще в использовании
        /// </summary>
        [Description("Один или несколько инструментов еще в использовании")]
        ToolIsInUse = 830,
        #endregion

        #region Message validation code 9xx

        /// <summary>
        /// The msg required.
        /// </summary>
        [Description("The message field is required")]
        MsgRequired = 900,

        /// <summary>
        /// The msg required.
        /// </summary>
        [Description("The message field must have less 256 characters")]
        MsgTooLong = 901,

        #endregion

        #region Friend validation code 10xx

        /// <summary>
        ///     The friend id required
        /// </summary>
        [Description("The friend id required")]
        FriendIdRequired = 1000,

        /// <summary>
        ///     The friend id already exists
        /// </summary>
        [Description("The friend id already exists")]
        FriendIsDuplicate = 1001,

        /// <summary>
        ///     The friend id value must be exist in DB
        /// </summary>
        [Description("The friend id value must be exist in DB")]
        FriendIsAbsent = 1002,

        /// <summary>
        ///     The friend message is out of lenght
        /// </summary>
        [Description("The message is out of lenght")]
        MessageOutOfLenght = 1003,
        /// <summary>
        /// The friend invite parameters is incorrect
        /// </summary>
        [Description("The friend invite parameters is incorrect")]
        InviteParamIncorrect = 1004,

        #endregion

        #region Settings validation code 11xx

        /// <summary>
        ///     The karma setting field is required
        /// </summary>
        [Description("The karma setting field is required")]
        KarmaRequired = 1100,

        /// <summary>
        ///     The loc visibility setting field is required
        /// </summary>
        [Description("The loc visibility setting field is required")]
        LocVisibilityRequired = 1101,

        /// <summary>
        ///     The tag setting field is required
        /// </summary>
        [Description("The tag setting field is required")]
        TagRequired = 1102,

        /// <summary>
        ///     The apns setting field is required
        /// </summary>
        [Description("The apns setting field is required")]
        ApnsRequired = 1103,

        /// <summary>
        ///     The rating setting field is required
        /// </summary>
        [Description("The rating setting field is required")]
        RatingRequired = 1104,

        /// <summary>
        ///     The tag setting field is required
        /// </summary>
        [Description("The tag setting field is out of range")]
        TagOutOfRange = 1105,

        /// <summary>
        ///     The tag setting field is required
        /// </summary>
        [Description("The apns setting field is out of range")]
        ApnsOutOfRange = 1106,

        #endregion

        #region  Media validation code 12xx
        /// <summary>
        /// The media id value is required
        /// </summary>
        [Description("The media id value is required")]
        MediaIdRequired = 1200,
        /// <summary>
        /// The media id value is incorrect
        /// </summary>
        [Description("The media with id value is not found")]
        MediaIdIncorrect = 12001,
        /// <summary>
        /// Can not send media to own UI
        /// </summary>
        [Description("Can not send media to own UI")]
        SendOwnUI = 12002,
        /// <summary>
        /// Recipient not found
        /// </summary>
        [Description("Recipient not found")]
        RecepientUIError = 12003,
        /// <summary>
        /// Duplicate media
        /// </summary>
        [Description("Duplicate media")]
        DuplicateMedia = 12004,
        #endregion

        #region Response validation code 13xx
        /// <summary>
        /// The response id is required
        /// </summary>
        [Description("The response id is required")]
        ResponseIdRequired = 13000,
        /// <summary>
        /// The response with id value is not found
        /// </summary>
        [Description("The response with id value is not found")]
        ResponseNotFound = 13001,
        /// <summary>
        /// The response already completed
        /// </summary>
        [Description("The response already completed")]
        ResponseCompleted = 13002,
        #endregion

        #region Thresholds validation code 14xx
        /// <summary>
        /// The threshold id is required
        /// </summary>
        [Description("The threshold id is required")]
        MetricIdRequired = 14000,
        /// <summary>
        /// The list of thresholds have incorrect json format
        /// </summary>
        [Description("The list of thresholds have incorrect json format")]
        ThresholdListIncorrectFormat = 14001,
        /// <summary>
        /// The threshold value is required
        /// </summary>
        [Description("The threshold value is required")]
        ThresholdValueRequired = 14002,
        /// <summary>
        /// The threshold value has incorrect format
        /// </summary>
        [Description("The threshold value has incorrect format")]
        ThresholdValueIncorrectFormat = 14003,
        /// <summary>
        /// The threshold value has incorrect format
        /// </summary>
        [Description("The field id is required or must be more than zero (0)")]
        IDIsRequired = 14004,
        /// <summary>
        /// The threshold value has incorrect format
        /// </summary>
        [Description("Thresholds are required!")]
        ThresholdsRequired = 14005,
        /// <summary>
        /// Application id list is empty
        /// </summary>
        [Description("Application id list is empty!")]
        AppIDListEmpty = 14006,
        /// <summary>
        /// One ore more thresholds have incorrect value.
        /// </summary>
        [Description("One ore more thresholds have incorrect value.")]
        ThresholdsIncorrectValue = 14007,
        #endregion*/

        #region Maintenances validation code 15xx
        /// <summary>
        /// The from period is empty or have incorrect format
        /// </summary>
        [Description("The From period is empty or have incorrect format")]
        FromPeriodIncorrect = 15000,
        /// <summary>
        /// The To period is empty or have incorrect format
        /// </summary>
        [Description("The To period is empty or have incorrect format")]
        ToPeriodIncorrect = 15001,
        /// <summary>
        /// The repeatable type is required
        /// </summary>
        [Description("The repeatable type has incorrect format")]
        RepeatableTypeRequired = 15002,
        /// <summary>
        /// The comment is required
        /// </summary>
        [Description("The comment is required")]
        CommentRequired = 15003,
        /// <summary>
        /// The application ID is required
        /// </summary>
        [Description("The application ID is required")]
        ApplicationIDRequired = 15004,
        /// <summary>
        /// Maintenance type is required
        /// </summary>
        [Description("Maintenance type is required")]
        MaintenanceTypeRequired = 15005,
        /// <summary>
        /// Maintenance profile ID is required
        /// </summary>
        [Description("Maintenance profile ID is required")]
        ProfileIDRequired = 15006,
        /// <summary>
        /// Maintenance profile is already added to this application!
        /// </summary>
        [Description("Maintenance profile is already added to this application!")]
        ProfileAlreadyAdded = 15007,
        #endregion

        #region Report validation code 16xx
        /// <summary>
        /// The FromDate is required
        /// </summary>
        [Description("The FromDate is required")]
        DateFromRequired = 16000,
        /// <summary>
        /// The ToDate is required
        /// </summary>
        [Description("The ToDate is required")]
        DateToRequired = 16001,
        /// <summary>
        /// The date period is required
        /// </summary>
        [Description("The date period is required")]
        DatePeriodRequired = 16002,
        /// <summary>
        /// The application id list is required
        /// </summary>
        [Description("The application id list is required")]
        AppIdsRequired = 16003,
        /// <summary>
        /// The Month value must be in range 0 and 11
        /// </summary>
        [Description("The Month value must be in range 0 and 11")]
        MonthIncorrect = 16004,
        /// <summary>
        /// The Year is required
        /// </summary>
        [Description("The Year is required")]
        YearRequired = 16005,
        #endregion*/

        #region Configuration error codes 17x
        /// <summary>
        /// The interval must be more, equal or multiple of 5.
        /// </summary>
        [Description("The interval must be more or equal 5 and multiple of 5.")]
        IncorrectInterval = 17000,
        /// <summary>
        /// The service for import time values is not installed on the server where API is installed!
        /// </summary>
        [Description("The service for import time values is not installed on the server where API is installed!")]
        ServiceNotInstalled = 17001,
        /// <summary>
        /// The service for import time values is not running, please, run it first
        /// </summary>
        [Description("The service for import time values is not running, please, run it first!")]
        ServiceNotRunning = 17002,
        #endregion
    }
}