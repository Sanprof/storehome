using StoreHouse.Models.Constants;
using System.Collections;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace StoreHouse.Models.Validation
{
    public static class Validator
    {
        /// <summary>
        /// Validates object and all of its children.
        /// </summary>
        /// <param name="item">
        /// The object for validation.
        /// </param>
        /// <returns>
        /// The <see cref="Code"/>.
        /// </returns>
        public static Code Validate(object item)
        {
            if (item != null)
            {
                var status = item.GetType()
                     .GetCustomAttributes(typeof(ValidationAttribute), true)
                     .OfType<ValidationAttribute>()
                     .Where(p => !p.IsValid(item))
                     .OfType<ICodeValidation>()
                     .Select(p => p.ErrorCode)
                     .FirstOrDefault();

                if (status != default(Code))
                {
                    return status;
                }

                foreach (var prop in item.GetType().GetProperties())
                {
                    status = prop.GetCustomAttributes(typeof(ValidationAttribute), true)
                        .OfType<ValidationAttribute>()
                        .Where(attr => !attr.IsValid(prop.GetValue(item)))
                        .OfType<ICodeValidation>()
                        .Select(p => p.ErrorCode)
                        .FirstOrDefault();

                    if (status != default(Code))
                    {
                        return status;
                    }

                    if (prop.PropertyType.IsClass)
                    {
                        if (prop.PropertyType.IsGenericType)//list
                        {
                            IEnumerable enumValue = (prop.GetValue(item) as IEnumerable);
                            if (enumValue != null)
                                foreach (var li in enumValue)
                                {
                                    status = Validate(li);
                                    if (status != default(Code))
                                    {
                                        return status;
                                    }
                                }
                        }
                        else if (!item.GetType().FullName.Contains("Newtonsoft"))
                        {
                            status = Validate(prop.GetValue(item));

                            if (status != default(Code))
                            {
                                return status;
                            }
                        }
                    }
                }
            }
            return default(Code);
        }
    }
}