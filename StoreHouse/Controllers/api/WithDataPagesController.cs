using StoreHouse.Common;
using StoreHouse.Models;
using StoreHouse.Models.Constants;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using System.Web.Http;

namespace StoreHouse.Controllers
{
    public abstract class WithDataPagesController : BaseApiController
    {
        [HttpGet]
        [Route("")]
        [HttpGetType(typeof(TokenBase))]
        [ParameterConverter(Parameter = "data")]
        public virtual async Task<IHttpActionResult> GetAllDataRequest(dynamic data)
        {
            dynamic response = GetAllData(data);
            return Ok(ApiResponseManager.CreateResponse(new Status(), new { count = response.Count, data = response }));
        }

        [HttpGet]
        [Route("partial")]
        [HttpGetType(typeof(ListPartialModel))]
        [ParameterConverter(Parameter = "data")]
        public virtual async Task<IHttpActionResult> GetPartialData(dynamic data)
        {
            var response = GetSortableAndGroupedData(data);
            return Ok(ApiResponseManager.CreateResponse(new Status(response != null ? Code.Success : Code.AuthRequired), response));
        }

        protected abstract List<object> GetAllData(dynamic data);

        protected virtual object GetAdditionDataBeforeSorting(dynamic response, dynamic data)
        {
            return null;
        }

        protected virtual object GetAdditionDataAfterSorting(dynamic response, dynamic data)
        {
            return null;
        }

        protected virtual object GetSortableAndGroupedData(dynamic data)
        {
            int count = 0;
            string fieldName = data.sort.field;
            var response = GetAllData(data as TokenBase);
            if (response == null)
                return null;
            string searchStr = !String.IsNullOrWhiteSpace(data.sort.search) ? data.sort.search.ToLower() : null;
            dynamic result = new ExpandoObject();
            object beforeSortingObj = this.GetAdditionDataBeforeSorting(response, data);
            if (beforeSortingObj != null)
                result.beforeextended = beforeSortingObj;
            if (!string.IsNullOrWhiteSpace(searchStr) && response.Count > 0)
            {
                Type myListElementType = response[0].GetType();
                if (myListElementType == typeof(ExpandoObject))
                {
                    response = response
                        .Where(t => ((IDictionary<string, object>)t)
                                        .Values
                                        .Where(v => !string.IsNullOrWhiteSpace(Convert.ToString(v)) && Convert.ToString(v).ToLower().Contains(searchStr.ToLower()))
                                        .Count() > 0)
                        .ToList();
                }
                else
                {
                    List<object> searchedList = new List<object>();
                    foreach (var item in response)
                    {
                        var pis = item.GetType().GetProperties();
                        bool isInSearch = false;
                        foreach (var pi in pis)
                        {
                            string value = Convert.ToString(pi.GetValue(item, null));
                            if (!string.IsNullOrWhiteSpace(value) && value.ToLower().Contains(searchStr.ToLower()))
                            {
                                isInSearch = true;
                                break;
                            }
                        }
                        if (isInSearch)
                            searchedList.Add(item);
                    }
                    response = searchedList;
                }
            }
            count = response.Count;
            if (data.sort != null && data.sort.field != null && count > 0)
            {
                Type myListElementType = response[0].GetType();
                if (myListElementType == typeof(ExpandoObject))
                {
                    if (data.sort.asc)
                        response = response
                            .Where(t => ((IDictionary<string, object>)t).Keys.Contains(fieldName))
                            .OrderBy(t => ((IDictionary<string, object>)t)[fieldName])
                            .ToList();
                    else
                        response = response
                            .Where(t => ((IDictionary<string, object>)t).Keys.Contains(fieldName))
                            .OrderByDescending(t => ((IDictionary<string, object>)t)[fieldName])
                            .ToList();
                }
                else
                {
                    if (data.sort.asc)
                        response = response
                            .OrderBy(t => t.GetType().GetProperty(fieldName, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).GetValue(t, null))
                            .ToList();
                    else
                        response = response
                            .OrderByDescending(t => t.GetType().GetProperty(fieldName, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).GetValue(t, null))
                            .ToList();
                }
            }
            result.count = count;

            if (response.Count > data.psize && count > 0)
            {
                int psize = (int)data.psize;
                int pindex = (int)data.pindex;
                response = response.Skip(psize * (pindex - 1)).Take(psize).ToList();
            }
            object afterSortingObj = this.GetAdditionDataAfterSorting(response, data);
            if (afterSortingObj != null)
                result.afterextended = afterSortingObj;
            result.data = response;
            return result;
        }
    }
}
