using StoreHouse.Models.Constants;
using System.ComponentModel;
using System.Linq;

namespace StoreHouse.Models
{
    /// <summary>
    ///     The status.
    /// </summary>
    public class Status
    {
        #region Constructors and Destructors

        /// <summary>
        /// Initializes a new instance of the <see cref="Status"/> class.
        /// </summary>
        public Status()
            : this(Code.Success)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="Status"/> class.
        /// </summary>
        /// <param name="code">
        /// The status code of response.
        /// </param>
        public Status(Code code)
        {
            this.Code = code;
        }

        #endregion

        #region Public Properties

        /// <summary>
        ///     Gets or sets the status code of response.
        /// </summary>
        public Code Code { get; set; }

        /// <summary>
        ///     Gets the status message message.
        /// </summary>
        public string Message
        {
            get
            {
                var attribute = this.Code.GetType().GetField(this.Code.ToString())
                    .GetCustomAttributes(typeof(DescriptionAttribute), false)
                    .SingleOrDefault() as DescriptionAttribute;

                return attribute != null ? attribute.Description : string.Empty;
            }
        }
        #endregion
    }
}