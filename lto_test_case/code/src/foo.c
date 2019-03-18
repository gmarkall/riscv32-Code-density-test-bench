/* 
* SPDX-License-Identifier: Apache-2.0
* Copyright 2019 Western Digital Corporation or its affiliates.
* 
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
* 
* http:*www.apache.org/licenses/LICENSE-2.0
* 
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

#include <stdio.h>

int foo(void);
int getStart(int pivot);
int getEnd(int pivot);
int getLCM(int a, int b);

int foo(void)
{
	int i=0;
	int j=100;
	int x=0;

	i=getStart(i);
	j=getEnd(j);
	j=getLCM(i, j);
	for(i; i< j; i++)
		x += i;
	return 0;
}

int getStart(int pivot)
{
	int start = 0;
	if (pivot > 0)
		start = pivot;
	else
		start = 100;
	return start;
}

int getEnd(int pivot)
{
	int end = 0;
	if (pivot > 0)
		end = pivot;
	else
		end = 100;
	return end;
}

int getLCM(int a, int b)
{
   int num1, num2, maxValue, result;

   num1 = a;
   num2 = b;
   maxValue = (num1 > num2) ? num1 : num2;

   while(1)  
   {
      if ((maxValue % num1 == 0) && (maxValue % num2 == 0))
      {
         result = maxValue;
         break;
      }
      ++maxValue;
   }
   return result;
}
