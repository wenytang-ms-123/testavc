﻿// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using NUnit.Framework;

namespace Microsoft.TeamsFx.SimpleAuth.Tests
{
    public class RetryHandler : DelegatingHandler
    {
        private const int MaxRetries = 8;

        public RetryHandler(HttpMessageHandler innerHandler)
            : base(innerHandler)
        {
        }

        protected override async Task<HttpResponseMessage> SendAsync(
            HttpRequestMessage request,
            CancellationToken cancellationToken)
        {
            HttpResponseMessage response = null;
            for (int i = 0; i < MaxRetries; i++)
            {
                response = await base.SendAsync(request, cancellationToken);
                if (response.IsSuccessStatusCode)
                {
                    return response;
                }
                await Task.Delay(1000 * i + 1000);
                TestContext.WriteLine(await response.Content.ReadAsStringAsync());
            }

            return response;
        }
    }
}
